extends CharacterBody2D


# Export variables
@export var speed = 35.0
@export var health = 3
@export var damage = 1

#  Standard Variables
var target = null
var facing = "Down"
var can_animate = true
var dying = false

# Onready variable
@onready var animation_player = $AnimationPlayer


func _ready():
	animation_player.play("IdleDown")

func _physics_process(_delta):
	if target:
		if can_animate:
			var direction = (target.global_position - global_position).normalized()
			velocity = direction * speed

			move_and_slide()

			if velocity.x > 10:
				facing = "Right"
			if velocity.x < -10:
				facing = "Left"
			if velocity.y > 10:
				facing = "Down"
			if velocity.y < -10:
				facing = "Up"

			animation_player.play("Walk" + facing)

func set_target(_target):
	target = _target

func clear_target():
	target = null

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		set_target(body)

func _on_area_2d_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		clear_target()

func hurt():
	can_animate = false
	if !dying:
		animation_player.play("Hurt" + facing)
		health -= 1

		if health == 0:
			dying = true
			animation_player.play("Die" + facing)


func _on_Hurt_finished():
	can_animate = true

func die():
	queue_free()
