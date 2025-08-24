; Identifiers
(identifier) @variable

((identifier) @type
  (#lua-match? @type "^[A-Z]"))

((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

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

; Literals
(string_literal) @string

(number_literal) @number

(boolean_literal) @boolean

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
  "xor"
  "|"
  "||"
  "~"
] @operator

; Keywords
[
  "if"
  "else if"
  "elif"
  (else_statement)
  (endif_statement)
] @keyword.conditional

[
  "is"
  "is not"
  "defined"
] @constant.builtin

[
  "for"
  "in"
  (break_statement)
  (continue_statement)
  (endfor_statement)
] @keyword.repeat

[
  "match"
  (endmatch_statement)
  "when"
  "with"
  (endwhen_statement)
] @keyword.conditional

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

[
  "as"
  "extends"
  "import"
  "include"
] @keyword.import

[
  "let"
  "mut"
  "set"
] @keyword

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

; Field variables
(field_expression
  field: (field_identifier) @variable.member)

(field_expression
  field: (number_literal) @variable.member)

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

((identifier) @constant.builtin
  (#any-of? @constant.builtin "Some" "None" "Ok" "Err"))

((identifier) @module
  (#any-of? @module "crate" "super" "self"))

; Builtin
(field_expression
  value: (identifier) @constant.builtin
  field: (field_identifier) @constant.builtin
  (#any-of? @constant.builtin "loop"))

(call_expression
  function: (identifier) @constant.builtin
  (#eq? @constant.builtin "caller"))

(call_expression
  function: (identifier) @constant.macro
  (#eq? @constant.macro "super" ))

; Filter names
(filter_expression
  filter: (identifier) @function.builtin)

; Comments
(comment) @comment @spell

; Specials
(placeholder) @character.special

(remaining_field) @character.special
