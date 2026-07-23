;; reference: https://github.com/nextflow-io/nextflow/blob/37da32c7fe3cda494d516a6d5e1fdbf02959fc9c/docs/reference/syntax.mdx
;; reference: https://github.com/nextflow-io/tree-sitter-nextflow/blob/172d3fef409aa1220fa9c10bc674e7dc675710e3/queries/highlights.scm
;; reference: https://github.com/valentinegb/zed-groovy/blob/63ff013c95dd653fa86640d77dc9e0f01b379b7a/languages/groovy/highlights.scm

[
  "process" "workflow" "include" "from" "def"
  "if" "else" "assert" "return" "try" "catch" "finally" "new"
] @keyword

(shebang) @preproc

"exit" @function

;; Nextflow declarations

(feature_flag
  "nextflow" @variable.special)

(parameter
  "params" @variable.special
  (identifier) @property)

[
  (include_item
    (identifier) @function)
  (process_definition
    (identifier) @function)
  (workflow_definition
    (identifier) @function)
]

(function_definition
  (identifier) @function
  . "(")

(cast_expression
  "as"
  [(identifier) (dotted_identifier)] @type)

(constructor_call
  "new"
  [(identifier) (dotted_identifier)] @type)

(closure_parameter) @variable.parameter

;; Process and workflow sections

["input:" "output:" "when:" "take:" "main:" "emit:"] @label

(script_declaration
  ["script" "shell" "exec" "stub"] @label)

(directive
  . (identifier) @attribute)

(label_statement
  . (identifier) @label)

(option_entry
  . (identifier) @property)

;; Calls, channel operations, and properties

[
  (command_expression
    . (identifier) @function)
  (function_call
    . (identifier) @function)
  (process_invocation
    . (identifier) @function)
]

(process_output
  . (identifier) @function
  "out" @property
  (identifier)? @property)

[
  (channel_factory
    (identifier) @function)
  (channel_from
    "from" @function)
  (channel_from_list
    "fromList" @function)
  (channel_of
    "of" @function)
  (channel_value
    "value" @function)
]

(map_operation
  "map" @function)

(operator_closure
  . (identifier) @function)

(pipe_operation
  . (identifier) @function)

(method_call
  (identifier) @function
  . ["(" (closure)])

(string_method_call
  (identifier) @function
  . "(")

(property_expression
  (identifier) @property)

(dotted_identifier
  . (identifier) @variable
  (identifier) @property)

"Channel" @type.builtin

;; Literals

[
  (string) (string_literal) (triple_quoted_string)
  (interpolated_string) (interpolated_triple_quoted_string)
] @string

(slashy_string) @string.regex
(escape_sequence) @string.escape

[(number) (integer_literal) (float_literal)] @number

[(boolean) (boolean_literal)] @boolean

(interpolation
  "$" @punctuation.special)

;; Operators

[
  "=" "+=" "-=" "*=" "/=" "%=" "**=" "<<=" ">>=" "&=" "|=" "^=" "?="
  "+" "-" "*" "/" "%" "**" "==" "!=" "<" ">" "<=" ">=" "&&" "||"
  ".." "..<" "=~" "as" "==~" "?:" "<=>" "<<" "&" "^" "|" "!" "~"
  "?" "->" "in" "instanceof" "?." "*."
] @operator

;; Brackets

["(" ")" "[" "]" "{" "}"] @punctuation.bracket

["," ";" ":" "."] @punctuation.delimiter

;; Comments

[(line_comment) (block_comment)] @comment
