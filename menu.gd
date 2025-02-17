extends CanvasLayer

@onready var HighScoreNormal=$HighScoreNormal
@onready var HighScoreHard=$HighScoreHard
@onready var HighScoreEasy=$HighScoreEasy


@onready var sound=$sound

var savepathnorm = "user://score_normal.txt"
var savepathhard = "user://score_hard.txt"
var savepatheasy = "user://score_easy.txt"
var high_scoreeasy=0
var high_scorehard=0
var high_scorenorm=0

func _ready():
	load_high_score()
	HighScoreNormal.text= "Highscore: " + str(high_scorenorm)
	HighScoreEasy.text= "Highscore: " + str(high_scoreeasy)
	HighScoreHard.text= "Highscore: " + str(high_scorehard)

func _on_easy_pressed():
	sound.play()
	sound.connect("finished",Callable(self,"_on_audio_finished_easy"))
	

func _on_audio_finished_easy():
	print("easy difficulty")
	get_tree().change_scene_to_file("res://Easy.tscn")
	

func _on_normal_pressed():
	sound.play()
	sound.connect("finished",Callable(self,"_on_audio_finished_normal"))

func _on_audio_finished_normal():
	print("Normal difficulty")
	get_tree().change_scene_to_file("res://Normal.tscn")

func _on_hard_pressed():
	sound.play()
	sound.connect("finished",Callable(self,"_on_audio_finished_hard"))
	
func _on_audio_finished_hard():
	print("hard difficulty")
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
	
func load_high_score():
	if FileAccess.file_exists(savepathnorm):
		var filenorm = FileAccess.open(savepathnorm, FileAccess.READ)
		high_scorenorm = filenorm.get_var()
		print(high_scorenorm)
	if FileAccess.file_exists(savepatheasy):
			var fileeasy = FileAccess.open(savepatheasy, FileAccess.READ)
			high_scoreeasy = fileeasy.get_var()
			print(high_scoreeasy)
	if FileAccess.file_exists(savepathhard):
		var filehard = FileAccess.open(savepathhard, FileAccess.READ)
		high_scorehard = filehard.get_var()
		print(high_scorehard)

#these are used to make the game score file paths and to call them to use in the menu
#below removes the high scores from their files
func _on_button_pressed():
	DirAccess.remove_absolute(savepathnorm)
	DirAccess.remove_absolute(savepathhard)
	DirAccess.remove_absolute(savepatheasy)
	print("High scores reset")
	get_tree().reload_current_scene()
