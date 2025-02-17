extends CanvasLayer

@onready var main=$"../../"

@onready var sound=$sound

#pause menu items with signals

func _on_exit_pressed():
	sound.play()
	sound.connect("finished",Callable(self,"_on_audio_finished_exit"))

func _on_audio_finished_exit():
	print("Exit pressed")
	get_tree().change_scene_to_file("res://menu_main.tscn")


func _on_continue_pressed():
	sound.play()
	main.pausemenu()
	
