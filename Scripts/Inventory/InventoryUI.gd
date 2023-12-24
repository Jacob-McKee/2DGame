extends Control

var is_open = false

@onready var inventory: Inventory = get_parent().inventory
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var player_number = get_parent().player_number

var selected_slot = 0

func _ready():
	update_slots()
	visible = false

func _process(_delta):
	if Input.is_action_just_pressed("inventory" + str(player_number)):
		toggle()
	
	if is_open:
		if Input.is_action_just_pressed("left"+str(player_number)):
			if inventory.remove_item_by_index(selected_slot, 1):
				update_slots()

func update_slots():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func toggle():
	if is_open:
		is_open = false
		visible = false
	else:
		is_open = true
		visible = true

func _on_grid_container_gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var slot = event.get_position() / 64
			print(slot)	
