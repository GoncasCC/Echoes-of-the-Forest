extends Area2D

var is_active = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		is_active = true
		show_memory_hint()

func show_memory_hint():
	# Display a hint or visual clue.
	print("A memory echo reveals a hint about the forest.")
