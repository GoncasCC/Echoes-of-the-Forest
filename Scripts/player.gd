extends CharacterBody2D

@export var speed = 100
@export var accel = 10

@onready var anim_player = $Sprite2D/AnimationPlayer

# Define frame indices for middle frame for each walking animation
# Adjust these values if the middle frame is not at index 1 (0-based index).
var middle_frame_indices = {
	"walk_right": 1,
	"walk_left": 1,
	"walk_up": 1,
	"forward_walk": 1
}

var current_animation = ""  # Track the current animation

func _ready() -> void:
	# Make sure no animation is playing at the start (optional)
	anim_player.stop()  # Stops any animation that might be playing
	# Set the default state to walking down if idle
	anim_player.play("forward_walk")
	current_animation = "forward_walk"  # Track the initial state

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Move the character
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	# Handle walking animations
	if direction != Vector2.ZERO:
		# If moving, check the direction and play the corresponding walking animation
		if direction.y > 0:
			if current_animation != "forward_walk":
				anim_player.play("forward_walk")
				current_animation = "forward_walk"
		elif direction.y < 0:
			if current_animation != "walk_up":
				anim_player.play("walk_up")
				current_animation = "walk_up"
		elif direction.x > 0:
			if current_animation != "walk_right":
				anim_player.play("walk_right")
				current_animation = "walk_right"
		elif direction.x < 0:
			if current_animation != "walk_left":
				anim_player.play("walk_left")
				current_animation = "walk_left"
	else:
		# If not moving, set the animation to the middle frame of the current animation
		if current_animation != "":
			if not anim_player.is_playing() or anim_player.current_animation != current_animation:
				anim_player.play(current_animation)
			
			# Pause the animation at the middle frame of the current animation
			anim_player.seek(anim_player.current_animation_length * (middle_frame_indices[current_animation] / 3), true)
	
	# Apply the movement
	move_and_slide()


