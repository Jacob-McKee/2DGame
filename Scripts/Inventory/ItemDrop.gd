extends Node

@export var item_reference: InventoryItem

func _ready():
	if item_reference:
		$Sprite2D.texture = item_reference.texture

func _on_body_entered(body:Node2D):
	if body.is_in_group("Player") and item_reference != null:
		body.add_item_to_inventory(item_reference)
		queue_free()
