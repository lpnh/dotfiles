; Based on
; https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/rust/highlights.scm

; Identifiers
(identifier) @variable

((identifier) @type
  (#lua-match? @type "^[A-Z]"))

(type_identifier) @type

(primitive_type) @type.builtin

(field_identifier) @variable.member

; Function definition
(function_item
  name: (identifier) @function)

(parameter
  (identifier) @variable.parameter)

; Function call
(call_expression
  function: (identifier) @function)

; Literals
(boolean_literal) @boolean

(integer_literal) @number

; Keywords
"fn" @keyword.function

"let" @keyword

[
  "if"
  "else"
] @keyword.conditional

"while" @keyword.repeat

"struct" @keyword.type

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "%"
  "<="
  ">="
  "<"
  ">"
  "=="
  "!="
  "="
] @operator

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ":"
  ";"
  "->"
] @punctuation.delimiter


; Comments
(line_comment) @comment @spell

(block_comment) @comment @spell
