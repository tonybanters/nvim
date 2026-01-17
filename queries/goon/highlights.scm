; Keywords
"let" @keyword
"if" @keyword.conditional
"then" @keyword.conditional
"else" @keyword.conditional
"import" @keyword.import

; Literals
(string) @string
(string_content) @string
(escape_sequence) @string.escape
(number) @number
(boolean) @boolean

; Identifiers
(identifier) @variable

; Types
(type_annotation) @type

; Fields
(record_field
  key: (identifier) @property)

(field_access
  (identifier) @property)

; Functions
(call_expression
  function: (identifier) @function.call)

; Operators
"=" @operator
":" @punctuation.delimiter
"?" @operator
"..." @operator
"." @punctuation.delimiter

; Punctuation
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"(" @punctuation.bracket
")" @punctuation.bracket
";" @punctuation.delimiter
"," @punctuation.delimiter

; Interpolation
(interpolation
  "${" @punctuation.special
  "}" @punctuation.special)

; Comments
(comment) @comment
