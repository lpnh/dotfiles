; Identifiers
(identifier) @variable

((identifier) @type
  (#lua-match? @type "^[A-Z]"))

((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

(path_expression
  path: (identifier) @module)

(path_expression
  name: (identifier) @module)

(path_expression
  path: (identifier) @type
  (#lua-match? @type "^[A-Z]"))

(path_expression
  name: (identifier) @type
  (#lua-match? @type "^[A-Z]"))

((path_expression
  name: (identifier) @constant)
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

((path_expression
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
] @punctuation.bracket

; Operators
[
  "|"
] @punctuation.bracket

[
  "!"
  "&"
  "~"
  "="
  ".."
  "..="
  "bitor"
  "xor"
  "bitand"
  "&&"
  "||"
  "+"
  "-"
  "*"
  "/"
  "%"
  "<"
  "<="
  ">"
  ">="
  "=="
  "!="
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
] @keyword

[
  "extends"
  "include"
  "import"
  "as"
] @keyword.import

[
  "let"
  "set"
  "mut"
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
(field_access_expression
  field: (field_identifier) @variable.member)

(field_access_expression
  field: (number_literal) @variable.member)

; Function calls
(call_expression
  function: (identifier) @function.call)

(call_expression
  (field_access_expression
    field: (field_identifier) @function.call))

(call_expression
  (path_expression
    name: (identifier) @function))

; Macro invocations
(macro_invocation
  macro: (identifier) @constant.macro)

(macro_invocation
  macro: (path_expression
    (identifier) @constant.macro .))

(macro_invocation
  "!" @constant.macro)

(call_expression
  function: (identifier) @constant.builtin
  (#any-of? @constant.builtin "caller"))

((identifier) @constant.builtin
  (#any-of? @constant.builtin "Some" "None" "Ok" "Err"))

((identifier) @module
  (#any-of? @module "crate" "super" "self"))

; Filter names
(filter
  name: (identifier) @function.builtin)

; Comments
(comment) @comment @spell

; Specials
(placeholder) @character.special

(wildcard) @character.special
