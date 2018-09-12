extends KinematicBody2D

const DIR = preload("res://characters/player/input/directions.gd")

onready var sprite = get_node("Sprite")

var speed = Vector2(400, 400)

export var damage = 1
export var speed_factor = 1.5
export var damages_player = false

func _physics_process(delta):
	apply_speed_scale(delta)
	sprite.set_rotation(self.speed.angle())
	if (is_colliding_with_wall(self)):
		self.queue_free()

func apply_speed_scale(delta):
	move_and_collide(self.speed * delta * self.speed_factor)

func get_speed_scale():
	return speed

func is_colliding_with_wall(bullet):
	if (bullet.is_colliding() and bullet.get_collider().get_type() == 'TileMap'):
		return true
	return false

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.ai.hit(self)
	if damages_player and area.get_parent().get_name() == 'Player':
		var player = area.get_parent()
		player.deal_damage(self.damage)
		queue_free()
