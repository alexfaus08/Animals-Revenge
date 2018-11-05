extends AcceptDialog

onready var world = $"../../World"
onready var Player = $"../Player"


func _ready():
	var dialog = AcceptDialog.new()
	self.add_child(dialog)
	