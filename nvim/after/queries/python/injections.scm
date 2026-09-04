;; extends

; Inject markdown parsing into Python docstrings (expression_statement strings)
((expression_statement
   (string) @injection.content)
 (#set! injection.language "markdown"))
