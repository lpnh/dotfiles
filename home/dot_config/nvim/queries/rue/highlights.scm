(identifier) @variable
(primitive_type) @type.builtin

(call_expression
  function: (identifier) @function)

(function_item
  name: (identifier) @function)

(line_comment) @comment
(block_comment) @comment

[
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ";"
] @punctuation.delimiter

(parameter
  (identifier) @variable.parameter)

[
  "fn"
  "let"
  "if"
  "else"
  "while"
] @keyword

(boolean_literal) @boolean
(integer_literal) @number
