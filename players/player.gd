extends CharacterBody2D

const SPEED = 120

var input_direction = Vector2.ZERO
var sprite_direction = "Down"

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	input_direction = get_input_direction()
	velocity = input_direction * SPEED
	move_and_slide()
	
	if input_direction != Vector2.ZERO:  # Use input_direction instead of velocity to determine walking
		set_animation("Walk")
	else:
		set_animation("Idle")

func set_animation(animation):
	var direction = "Side" if sprite_direction in ["Left", "Right"] else sprite_direction
	var new_animation = animation + direction
	
	# Only play if the animation has changed
	if sprite.animation != new_animation:
		sprite.play(new_animation)
	
	sprite.flip_h = (sprite_direction == "Left")

func get_input_direction():
	var x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	var direction = Vector2(x, y).normalized()
	
	if direction != Vector2.ZERO:
		if direction.x < 0:
			sprite_direction = "Left"
		elif direction.x > 0:
			sprite_direction = "Right"
		elif direction.y < 0:
			sprite_direction = "Up"
		elif direction.y > 0:
			sprite_direction = "Down"
	
	return direction
