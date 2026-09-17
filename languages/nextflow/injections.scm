;; Bash injection into process script/shell/stub bodies.
;; `exec:` is deliberately excluded: its body is Groovy, not shell.

;; Interpolated strings capture only the content chunks, so quote delimiters
;; and ${...} interpolations stay Nextflow. injection.combined merges the
;; chunks around each interpolation back into one bash document.
(script_declaration
  ["script" "shell" "stub"]
  ":"
  (script_content
    (interpolated_triple_quoted_string
      (triple_string_content) @injection.content))
  (#set! injection.language "bash")
  (#set! injection.combined))

(script_declaration
  ["script" "shell" "stub"]
  ":"
  (script_content
    (interpolated_string
      (string_content) @injection.content))
  (#set! injection.language "bash")
  (#set! injection.combined))

;; Non-interpolated strings are single tokens with no content child, so the
;; injection includes the quote delimiters.
(script_declaration
  ["script" "shell" "stub"]
  ":"
  (script_content
    (triple_quoted_string) @injection.content)
  (#set! injection.language "bash"))

(script_declaration
  ["script" "shell" "stub"]
  ":"
  (script_content
    (string_literal) @injection.content)
  (#set! injection.language "bash"))
