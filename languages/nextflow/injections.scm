(script_declaration
  ["script" "shell" "stub"]
  ":"
  (script_content
    [
      (interpolated_string
        (string_content) @injection.content)
      (interpolated_triple_quoted_string
        (triple_string_content) @injection.content)
    ])
  (#set! injection.language "bash"))
