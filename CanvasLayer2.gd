extends CanvasLayer

@onready var sound=$sound

#death menu with a restart button and an exit to menu button

func _on_exit_pressed():
	sound.play()
	sound.connect("finished",Callable(self,"_on_audio_finished_exit"))

func _on_audio_finished_exit():
	print("Exit pressed")
	get_tree().change_scene_to_file("res://menu_main.tscn")


func _on_restart_pressed():
	sound.play()
	sound.connect("finished",Callable(self,"_on_audio_finished_restart"))


func _on_audio_finished_restart():
	get_tree().reload_current_scene()
