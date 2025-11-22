; Identifier conventions
(identifier) @variable

((identifier) @type
  (#lua-match? @type "^[A-Z]"))

((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

; Other identifiers
(scoped_identifier
  path: (identifier) @module)

(scoped_identifier
  name: (identifier) @module)

(scoped_identifier
  path: (identifier) @type
  (#lua-match? @type "^[A-Z]"))

(scoped_identifier
  name: (identifier) @type
  (#lua-match? @type "^[A-Z]"))

((scoped_identifier
  name: (identifier) @constant)
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

((scoped_identifier
  path: (identifier) @type
  name: (identifier) @constant)
  (#lua-match? @type "^[A-Z]")
  (#lua-match? @constant "^[A-Z]"))

((identifier) @constant.builtin
  (#any-of? @constant.builtin "Some" "None" "Ok" "Err"))

((identifier) @module
  (#any-of? @module "crate" "super" "self"))

(primitive_type) @type.builtin

; Field identifiers
(field_expression
  field: (field_identifier) @variable.member)

(field_expression
  field: (number_literal) @variable.member)

; Specials
(placeholder) @character.special

(remaining_field) @character.special

; Macro definitions
(macro_statement
  name: (identifier) @function)

(endmacro_statement
  name: (identifier) @function)

; Parameters
(macro_statement
  arguments: (arguments (identifier) @variable.parameter))

; Function calls
(call_expression
  function: (identifier) @function.call)

(call_expression
  (field_expression
    field: (field_identifier) @function.call))

(call_expression
  (scoped_identifier
    name: (identifier) @function))

; Macro invocations
(macro_invocation
  macro: (identifier) @constant.macro)

(macro_invocation
  macro: (scoped_identifier
    (identifier) @constant.macro .))

(macro_invocation
  "!" @constant.macro)

; Builtin
(field_expression
  value: (identifier) @constant.builtin
  (#eq? @constant.builtin "loop"))

(field_expression
  field: (field_identifier) @constant.builtin
  (#any-of? @constant.builtin "index" "index0" "first" "last"))

(call_expression
  function: (identifier) @constant.macro
  (#eq? @constant.macro "caller"))

(call_expression
  function: (identifier) @constant.macro
  (#eq? @constant.macro "super"))

; Filter expressions
(filter_expression
  filter: (identifier) @function.call)

(filter_statement
  (identifier) @function.method)

; Named arguments
(named_argument
  name: (identifier) @variable.parameter)

; Import aliases
(import_statement
  alias: (identifier) @variable)

; Literals
(string_literal) @string

(number_literal) @number

(boolean_literal) @boolean

; Keywords
[
  "as"
  "extends"
  "import"
  "include"
] @keyword.import

[
  "if"
  "else if"
  "elif"
  (else_statement)
  (endif_statement)
] @keyword.conditional

[
  "match"
  (endmatch_statement)
  "when"
  "with"
  (endwhen_statement)
] @keyword.conditional

[
  "for"
  "in"
  (break_statement)
  (continue_statement)
  (endfor_statement)
] @keyword.repeat

[
  "is"
  "is not"
  "defined"
] @constant.builtin

[
  "let"
  "mut"
  "set"
] @keyword

[
  "block"
  "endblock"
  "filter"
  (endfilter_statement)
  "macro"
  "endmacro"
  "call"
  (endcall_statement)
  "raw"
  "endraw"
] @keyword

; Operators
[
  "!"
  "!="
  "%"
  "&"
  "&&"
  "*"
  "+"
  "-"
  ".."
  "..="
  "/"
  "<"
  "<<"
  "<="
  "="
  "=="
  ">"
  ">="
  ">>"
  "?"
  "bitand"
  "bitor"
  "or"
  "xor"
  "|"
  "||"
  "~"
] @operator

; Punctuation
[
  ","
  "."
  "::"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; Delimiters
[
  "{%"
  "{%-"
  "{%+"
  "{%~"
  "%}"
  "-%}"
  "+%}"
  "~%}"
] @keyword.directive

[
  "{{"
  "{{-"
  "{{+"
  "{{~"
  "}}"
  "-}}"
  "+}}"
  "~}}"
] @keyword.directive

; Comments
(comment) @comment @spell
