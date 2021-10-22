extends CanvasLayer

func _process(_delta: float) -> void:
  # Hide HUD nodes when bodies go behind them
  var hide_nodes = get_tree().get_nodes_in_group("auto_hide")
  var bodies = get_tree().get_nodes_in_group("body")
  for node in hide_nodes:
    for body in bodies:
      if node.get_node("HideRegion").overlaps_body(body) or node.get_node("HideRegion").overlaps_area(body):
        node.modulate.a = 0.5
        break # move to next node
      else:
        node.modulate.a = 1
