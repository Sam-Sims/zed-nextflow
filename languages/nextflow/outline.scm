(process_definition
  "process" @context
  . (identifier) @name) @item

(workflow_definition
  "workflow" @context
  . (identifier) @name) @item

(workflow_definition
  "workflow" @name
  . "{") @item

(function_definition
  (identifier) @name
  . "(") @item
