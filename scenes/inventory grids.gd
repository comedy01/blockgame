extends GridContainer

var inventoryVisible = false

func _ready():
	self.visible = inventoryVisible

func _input(event):
	if Input.is_action_just_pressed("toggle_inventory"):
			inventoryVisible = not inventoryVisible
			self.visible = inventoryVisible
