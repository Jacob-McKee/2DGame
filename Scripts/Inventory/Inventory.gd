extends Resource

class_name Inventory

@export var items: Array[InventoryItem]

func add_item(item: InventoryItem) -> bool:
	for i in range(items.size()):
		if items[i] != null and items[i].name == item.name:
			items[i].amount += item.amount
			return true

	for i in range(items.size()):
		if items[i] == null:
			var new_item = InventoryItem.new()
			new_item.name = item.name
			new_item.texture = item.texture
			new_item.amount = item.amount
			items[i] = new_item
			return true

	return false

func remove_item(item: InventoryItem, amount: int) -> bool:
	if items.find(item) != -1:
		items.erase(items.find(item.name))
		return true
	return false

func remove_item_by_index(index: int, amount: int) -> bool:
	if items[index] != null:
		items[index] = null
		return true
	return false