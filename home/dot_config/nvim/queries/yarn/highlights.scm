; Identifiers
(identifier) @variable

(variable
  (identifier)) @variable

(title_header
  (identifier) @type)

(jump_statement
  (identifier) @type)

; Literals
(number) @number

(string) @string

(boolean) @boolean

; Punctuation
[
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
  "%"
  "&&"
  "*"
  "+"
  "-"
  "/"
  "<"
  "<="
  "="
  "=="
  ">"
  ">="
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
  "jump"
  "once"
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
(comment) @comment

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
