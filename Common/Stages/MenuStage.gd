extends Node

onready var StageHandler = get_node("/root/StageHandler")



func _on_PlayGame_pressed():
	StageHandler.load_game_stage()

func _on_Tutorial_pressed():
	$Control/TutorialPanel.visible = true

func _on_Quit_pressed():
	get_tree().quit()


func _on_CloseButton_pressed():
	$Control/TutorialPanel.visible = false
