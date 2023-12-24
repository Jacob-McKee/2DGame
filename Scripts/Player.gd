extends CharacterBody2D


@export var player_number = 1
@export var speed = 65

@export var inventory: Inventory
@export var inventory_ui: Control

var facing = 'Down'
var moving = false
var attacking = false

var health = 3
var stamina = 100

@onready var animation_player = $AnimationPlayer
@onready var healthbar = $HealthBar
@onready var staminawheel = $StaminaWheel

func _process(_delta):
	if !inventory_ui.visible:
		if Input.is_action_pressed("down"+str(player_number)):
			facing = 'Down'
		if Input.is_action_pressed("up"+str(player_number)):
			facing = 'Up'
		if Input.is_action_pressed("left"+str(player_number)):
			facing = 'Left'
		if Input.is_action_pressed("right"+str(player_number)):
			facing = 'Right'
	
		var direction = Input.get_vector("left"+str(player_number), "right"+str(player_number), "up"+str(player_number), "down"+str(player_number))
		velocity = direction * speed

		if !attacking:
			if velocity.length() > 0:
				animation_player.play("Walk"+facing)
			else:
				animation_player.play("Idle"+facing)
		
		if Input.is_action_just_pressed('action'+str(player_number)) and !attacking:
			attacking = true
			animation_player.play("Attack"+facing)
			update_stamina(-10)

		velocity = velocity.floor()
		move_and_slide()

func add_item_to_inventory(item: InventoryItem):
	inventory.add_item(item)
	inventory_ui.call_deferred("update_slots")

func remove_item_from_inventory(item: InventoryItem, amount: int):
	inventory.remove_item(item, amount)
	inventory_ui.call_deferred("update_slots")

func damage(amount):
	health -= amount
	healthbar.value = health
	if health <= 0:
		pass

func update_stamina(amount):
	stamina += amount
	if stamina > 100:
		stamina = 100
	if stamina < 1:
		stamina = 0
	staminawheel.material.set_shader_parameter("value", stamina)

func attack_finished():
	attacking = false

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		body.hurt()
