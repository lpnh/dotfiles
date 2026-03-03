; Identifiers
(identifier) @variable

(variable
  "$" @punctuation.special
  (identifier) @variable)

(title_header
  (identifier) @type)

(jump_statement
  (identifier) @type)

(enum_statement
  name: (identifier) @type)

(enum_case_statement
  name: (identifier) @constant)

(declare_statement
  type: (identifier) @type)

(member_expression
  type: (identifier) @type
  member: (identifier) @variable.member)

(member_expression
  member: (identifier) @variable.member)

(command_statement .
  (identifier) @function.call)

; Literals
(number) @number

(string) @string

(boolean) @boolean

; Punctuation
[
  "."
  ":"
  "---"
  "==="
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

; Operators
[
  "!"
  "!="
  "%"
  "%="
  "&&"
  "*"
  "*="
  "+"
  "+="
  "-"
  "-="
  "/"
  "/="
  "<"
  "<="
  "="
  "=="
  ">"
  ">="
  "^"
  "and"
  "eq"
  "gt"
  "gte"
  "is"
  "lt"
  "lte"
  "neq"
  "not"
  "or"
  "xor"
  "||"
] @operator

"to" @keyword.operator

; Keywords
[
  "if"
  "elseif"
  "else"
  "endif"
  "when"
] @keyword.conditional

[
  "always"
  "as"
  "call"
  "case"
  "declare"
  "detour"
  "enum"
  "endenum"
  "jump"
  "once"
  "endonce"
  "return"
  "set"
  "title"
] @keyword

[
  "<<"
  ">>"
] @keyword.directive

; Arrows
[
  "->"
  "=>"
] @keyword

; Comments
(comment) @comment @spell

; Tags
(header) @comment

(header
  header_key: (identifier) @comment)

; Hashtags
(hashtag) @comment

; Function calls
(function_call
  function: (identifier) @function.call)

; Dialog text
(text) @text
