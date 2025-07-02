return{

{
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
        theme = 'hyper',
        config = {
         header = {
            '',
          ' █████▒██▓    ▄▄▄    ██▒   █▓ ██▓ ███▄ ▄███▓',
          '▓██   ▒▓██▒   ▒████▄ ▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
          '▒████ ░▒██░   ▒██  ▀█▄▓██  █▒░▒██▒▓██    ▓██░',
          '░▓█▒  ░▒██░   ░██▄▄▄▄██▒██ █░░░██░▒██    ▒██ ',
          '░▒█░   ░██████▒▓█   ▓██▒▒▀█░  ░██░▒██▒   ░██▒',
          ' ▒ ░   ░ ▒░▓  ░▒▒   ▓▒█░░ ▐░  ░▓  ░ ▒░   ░  ░',
          ' ░     ░ ░ ▒  ░ ▒   ▒▒ ░░ ░░   ▒ ░░  ░      ░',
          ' ░ ░     ░ ░    ░   ▒     ░░   ▒ ░░      ░   ',
          '           ░  ░     ░  ░   ░   ░         ░   ',
          '                          ░                   ',
          },
         shortcut ={
          {
            desc = "Oh no!!! Not you again!!!",
          },
        },
          footer = {"", "Let’s pretend this never happened!"},
       },
      }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
}
