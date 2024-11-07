extends Area2D

var is_active = false

func _ready():
	$Sprite2D/AnimationPlayer.play("Default")
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		is_active = true
		show_memory_hint()
		

func _on_body_exited(body):
	if body.name == "Player":
		is_active = false
		hide_memory_hint()

func show_memory_hint():
	var hintLabel = get_tree().root.get_node("ForestArea/UI/HintLabel")
	# Display a hint or visual clue.
	hintLabel.visible = true
	
func hide_memory_hint():
	var hintLabel = get_tree().root.get_node("ForestArea/UI/HintLabel")
	hintLabel.visible = false
