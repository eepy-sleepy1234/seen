extends Node2D

@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var player: CharacterBody2D = $"../player"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var player_in_range = false


func _process(delta: float) -> void:
	if player.is_ghost:
		sprite.visible = true
	else:
		sprite.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if player.is_ghost == true:
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
