extends Node2D


# We need to:
# 1. Share the world of the first viewport with the second viewport.
# 2. Create a remote transform attached to each player that pushes their position to the camera.
# This data structure helps us to do that conveniently. See the _ready() function below.
@onready var players := {
	"1": {
		viewport = $HBoxContainer/SubViewportContainer/SubViewport,
		camera = $HBoxContainer/SubViewportContainer/SubViewport/Camera2D,
	},
	"2": {
		viewport = $HBoxContainer/SubViewportContainer2/SubViewport,
		camera = $HBoxContainer/SubViewportContainer2/SubViewport/Camera2D,
	}
}


func _ready() -> void:
	var player1 = load("res://Scenes/Characters/Player.tscn").instantiate()
	player1.player_number = 1
	player1.position = Vector2(50,50)
	$HBoxContainer/SubViewportContainer/SubViewport.add_child(player1)
	var player2 = load("res://Scenes/Characters/Player.tscn").instantiate()
	player2.player_number = 2
	player2.position = Vector2(75,75)
	$HBoxContainer/SubViewportContainer2/SubViewport.add_child(player2)

	# The world_2d object of the viewport contains information about what to
	# render. Here, it's our game level. We need to pass it from the first to
	# the second viewport for both of them to render the same level.
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	# For each player, we create a remote transform that pushes the character's
	# position to the corresponding camera.
	var remote_transform1 := RemoteTransform2D.new()
	remote_transform1.remote_path = players["1"].camera.get_path()
	player1.add_child(remote_transform1)

	var remote_transform2 := RemoteTransform2D.new()
	remote_transform2.remote_path = players["2"].camera.get_path()
	player2.add_child(remote_transform2)


func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

