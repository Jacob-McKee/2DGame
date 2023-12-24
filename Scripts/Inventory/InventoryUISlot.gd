extends Panel


@onready var item_visual: Sprite2D = $ItemDisplay
@onready var quantity: Label = $Quantity

func update(item: InventoryItem):
	if !item:
		item_visual.visible = false
		quantity.text = ""
		return
	item_visual.visible = true
	item_visual.texture = item.texture
	quantity.text = str(item.amount)
