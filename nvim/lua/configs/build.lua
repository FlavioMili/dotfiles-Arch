local M = {}
local running = false

-- Search from the file, rather than assuming Neovim was opened at the root.
function M.root(path)
  local markers = { ".git", "CMakeLists.txt", "CMakeCache.txt", "Makefile", "makefile", "GNUmakefile", "build.ninja" }
  -- Prefer the repository root so nested CMakeLists.txt do not hide build/.
  return vim.fs.root(path, { ".git" }) or vim.fs.root(path, markers) or vim.fn.getcwd()
end

function M.detect(root)
  local choices, seen = {}, {}
  local function add(argv, cwd)
    local label = table.concat(argv, " ")
    if not seen[label] then
      seen[label] = true
      choices[#choices + 1] = { argv = argv, cwd = cwd, label = label }
    end
  end
  for _, pattern in ipairs({ "CMakeCache.txt", "*/CMakeCache.txt", "out/build/*/CMakeCache.txt", "build/*/CMakeCache.txt", "_build/*/CMakeCache.txt" }) do
    for _, cache in ipairs(vim.fn.globpath(root, pattern, false, true)) do
      add({ "cmake", "--build", vim.fs.dirname(cache) }, root)
    end
  end
  -- Offer a project's wrapper Makefile too (it may provide its own defaults).
  for _, name in ipairs({ "GNUmakefile", "makefile", "Makefile" }) do
    if vim.fn.filereadable(root .. "/" .. name) == 1 then
      add({ "make" }, root)
      break
    end
  end
  if vim.fn.filereadable(root .. "/build.ninja") == 1 then
    add({ "ninja" }, root)
  end
  return choices
end

local function run(choice)
  if running then
    vim.notify("A build is already running", vim.log.levels.WARN)
    return
  end
  -- Save changes before compiling; abort if any buffer cannot be written.
  vim.cmd("wall")
  vim.cmd("botright 15new")
  local buf = vim.api.nvim_get_current_buf()
  vim.b[buf].build_root = choice.cwd
  running = true
  local job = vim.fn.jobstart(choice.argv, {
    cwd = choice.cwd,
    term = true,
    on_exit = function(_, code)
      running = false
      vim.schedule(function()
        vim.notify("Build " .. (code == 0 and "succeeded" or ("failed (exit " .. code .. ")")),
          code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR)
      end)
    end,
  })
  if job <= 0 then
    running = false
    vim.notify("Could not start build: " .. choice.label, vim.log.levels.ERROR)
  end
  vim.bo[buf].bufhidden = "hide"
end

function M.build(command)
  local name = vim.api.nvim_buf_get_name(0)
  local root = vim.b.build_root or M.root(name ~= "" and name or vim.fn.getcwd())
  if command and command ~= "" then
    run({ argv = command, cwd = root, label = command })
    return
  end
  local choices = M.detect(root)
  if #choices == 0 then
    vim.notify("No configured build found in " .. root .. ". Configure CMake first, or use :Build <command>.", vim.log.levels.WARN)
  elseif #choices == 1 then
    run(choices[1])
  else
    vim.ui.select(choices, {
      prompt = "Build project:",
      format_item = function(item) return item.label end,
    }, function(choice)
      if choice then run(choice) end
    end)
  end
end

function M.setup()
  vim.api.nvim_create_user_command("Build", function(opts) M.build(opts.args) end,
    { nargs = "*", desc = "Detect project build or run a custom build command", force = true })
end

return M
