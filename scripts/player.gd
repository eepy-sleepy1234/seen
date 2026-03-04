extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var speed = 100
@export var is_ghost = false
 
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		is_ghost = not is_ghost

func _physics_process(_delta):
	# setup direction of movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# stop diagonal movement by listening for input then setting axis to zero
	if is_ghost:
		set_collision_mask_value(2, true)
		set_collision_mask_value(1, false)
		modulate.a = 0.82
	else:
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, false)
		modulate.a = 1
		
	if Input.is_action_pressed("move_right"):
		sprite.flip_h = true
		if is_ghost:
			sprite.play("side_ghost")
		else:
			sprite.play("side")
	elif Input.is_action_pressed("move_left"):
		sprite.flip_h = false
		if is_ghost:
			sprite.play("side_ghost")
		else:
			sprite.play("side")
	elif Input.is_action_pressed("move_up"):
		if is_ghost:
			sprite.play("up_ghost")
		else:
			sprite.play("up")
	elif Input.is_action_pressed("move_down"):
		if is_ghost:
			sprite.play("down_ghost")
		else:
			sprite.play("down")
	else:
		if is_ghost:
			sprite.play("idle_ghost")
		else:
			sprite.play("idle")
	
	direction = direction.normalized()
	velocity = (direction * speed)
	move_and_slide()
