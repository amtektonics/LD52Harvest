extends Label


func _ready():
	self.text = ProjectSettings.get_setting("application/config/version")
