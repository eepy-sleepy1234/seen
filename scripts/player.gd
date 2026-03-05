extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var speed = 100
var last_direction = 0
@export var is_ghost = false

func _physics_process(_delta):
	# setup direction of movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
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
		last_direction = 2
		if is_ghost:
			sprite.play("side_ghost")
		else:
			sprite.play("side")
	elif Input.is_action_pressed("move_left"):
		sprite.flip_h = false
		last_direction = 4
		if is_ghost:
			sprite.play("side_ghost")
		else:
			sprite.play("side")
	elif Input.is_action_pressed("move_up"):
		last_direction = 1
		if is_ghost:
			sprite.play("up_ghost")
		else:
			sprite.play("up")
	elif Input.is_action_pressed("move_down"):
		last_direction = 3
		if is_ghost:
			sprite.play("down_ghost")
		else:
			sprite.play("down")
	else:
		if is_ghost:
			if last_direction == 1:
				sprite.play("idle_ghost_up")
			elif last_direction == 3:
				sprite.play("idle_ghost")
			elif last_direction == 2:
				sprite.play("idle_ghost_side")
			elif last_direction == 4:
				sprite.play("idle_ghost_side")
			else:
				sprite.play("idle_ghost")
		else:
			if last_direction == 1:
				sprite.play("idle_up")
			elif last_direction == 3:
				sprite.play("idle")
			elif last_direction == 2:
				sprite.play("idle_side")
			elif last_direction == 4:
				sprite.play("idle_side")
			else:
				sprite.play("idle")
	
	direction = direction.normalized()
	velocity = (direction * speed)
	move_and_slide()
