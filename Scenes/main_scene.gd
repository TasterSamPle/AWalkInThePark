extends Node

#creates links to items in the 2D view
@onready var dog = $Dog/Dog_base2
@onready var lives=$Lives/CanvasLayer/lives
@onready var death =$DeathScreen
@onready var score=$Score/Label
@onready var timer=$Timer/Label
@onready var treats=$treatTimer
@onready var nibble=$SpawnpointsNibble
@onready var bone=$SpawnpointsBone
@onready var bonecollecter=$Treats2
@onready var time=$Level_Time
@onready var score_print=$DeathScreen/Score

@onready var pause_menu=$Pausescreen/Pause

@onready var lose=$Lose

@onready var music=$Music

#loads assets for spawning
@onready var boned: PackedScene = preload("res://Bone.tscn")
@onready var nibs: PackedScene=preload("res://Nibble.tscn")


var start = true
var pauseactivated = false

var savepathnorm = "user://score_normal.txt"
var savepathhard = "user://score_hard.txt"
var savepatheasy = "user://score_easy.txt"

var high_scoreeasy=0
var high_scorenorm=0
var high_scorehard=0

var new_score=0
var end=false
var dead=false


func _ready():
	#resetting the scene and making the level visable after loading in
	death.hide()
	time.start()
	pause_menu.hide()
	pauseactivated=false
	Engine.time_scale=1
	score.show()
	dead=false
	end=false
	start=true
	load_high_score()
	print(OS.get_data_dir())

func _process(_delta):
	#below sets lives per levels as well as the camera
	if is_in_group("Normal") && (start==true):
		dog.lives=dog.lives
		start=false
	if is_in_group("Hard") && (start==true):
		dog.lives=dog.lives-1
		start=false
		dog.camera.limit_right=1000
		dog.camera.limit_bottom=2000
	if is_in_group("Easy") && (start==true):
		dog.lives=dog.lives+2
		start=false
		
		dog.camera.limit_right=1000
		dog.camera.limit_bottom=2000

	#controls the death screen
	if dog.lives<=0:
		death.show()
		dead=true
	
	#controls the labels for the score and runs the checker for the high score
	score.text= "Score:" + str(dog.score)
	score_print.text="Final Score:"+str(dog.score)
	savescore()

#pauses the game
	if Input.is_action_just_pressed("pause"):
		print("paused")
		pausemenu()

#sets the information on the timer
	var timeleft = round(time.time_left)
	timer.text="time:"+str(timeleft)

	#below manages the image for lives in the level
	if dog.lives==5:
		lives.texture=load("res://assets storage/Lives/BoneFive.png")
	elif dog.lives==4:
		lives.texture=load("res://assets storage/Lives/BoneFour.png")
	elif dog.lives==3:
		lives.texture=load("res://assets storage/Lives/BoneThree.png")
	elif dog.lives==2:
		lives.texture=load("res://assets storage/Lives/BoneTwo.png")
	elif dog.lives==1:
		lives.texture=load("res://assets storage/Lives/BoneOne.png")
	elif dog.lives==0:
		lives.texture=load("res://assets storage/Lives/BoneZero.png")
		savescore()
		#controls the ending sequence
		dog.lives =dog.lives-1
		end=true
		dog.End()

#controls the music for the level
	if music.is_playing() || pauseactivated==true || dead==true:
		return
	else:
		music.play()

#below compares score to high score then choses to save the high score or not
func savescore():
	if is_in_group("Normal") && (dog.score > high_scorenorm):
		high_scorenorm = dog.score
		save_high_score()
	if is_in_group("Hard") && (dog.score > high_scorehard):
		high_scorehard = dog.score
		save_high_score()
	if is_in_group("Easy") && (dog.score > high_scoreeasy):
		high_scoreeasy = dog.score
		save_high_score()

#controls the pause menu insuring everything in the level stops
func pausemenu():
	#variables control paused conditions
	if pauseactivated:
		pause_menu.hide()
		Engine.time_scale=1
		time.paused=false
		score_print.show()
		timer.show()
		score.show()
		
	else:
		pause_menu.show()
		Engine.time_scale=0
		time.paused=true
		score_print.hide()
		timer.hide()
		score.hide()
		music.stop()
		
	pauseactivated=!pauseactivated


func _on_treat_timer_timeout():
	#This is used to spawn in the bone treat on the map
	var newbone = boned.instantiate()
	var bonespawn = bone.get_children()
	var random_index = randi() % bonespawn.size()
	var random_element = bonespawn[random_index]
	#get postion of the markers used for the treats locations
	var pos = random_element.position
	newbone.position=pos
	add_child(newbone)
	#spawns in the bone
	
		#This is used to spawn in the bone treat on the map
	var newnib = nibs.instantiate()
	var nibspawn = nibble.get_children()
	var random_indexnib = randi() % nibspawn.size()
	var random_elementnib = nibspawn[random_indexnib]
	#get postion of the markers used for the treats locations
	var posnib = random_elementnib.position
	newnib.position=posnib
	add_child(newnib)
	#spawns in the nibbles

func save_high_score():
	#saves the high score to the high score file
	if is_in_group("Normal"):
		var filenorm = FileAccess.open(savepathnorm, FileAccess.WRITE) 
		filenorm.store_var(high_scorenorm)
	if is_in_group("Hard"):
		var filehard = FileAccess.open(savepathhard, FileAccess.WRITE) 
		filehard.store_var(high_scorehard)
	if is_in_group("Easy"):
		var fileeasy = FileAccess.open(savepatheasy, FileAccess.WRITE) 
		fileeasy.store_var(high_scoreeasy)


func load_high_score():
	#loads the level scores to reference as the high score
	if FileAccess.file_exists(savepathnorm):
		var filenorm = FileAccess.open(savepathnorm, FileAccess.READ)
		high_scorenorm = filenorm.get_var()

	if FileAccess.file_exists(savepatheasy):
		var fileeasy = FileAccess.open(savepatheasy, FileAccess.READ)
		high_scoreeasy = fileeasy.get_var()

	if FileAccess.file_exists(savepathhard):
		var filehard = FileAccess.open(savepathhard, FileAccess.READ)
		high_scorehard = filehard.get_var()


func _on_level_time_timeout():
	dog.lives=0
	# makes game end when there is no time remaining


