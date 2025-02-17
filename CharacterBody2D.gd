extends CharacterBody2D

@onready var dog = $Dog
@onready var skateboard = $Skateboard
@onready var pause =$/root/Sceneone/Pausescreen
@onready var main=$/root/Sceneone
@onready var lose=$/root/Sceneone/Lose
@onready var skate=$Skate
@onready var camera=$Camera2D
@onready var eat=$Eat
@onready var move=$Move

var left = 0
var score = 0
const SPEED = 450
var lives= 3

func _process(_delta):
	if !dog:
		return

	if lives<=0:
		print("no lives")
		dog.queue_free()


		

func End():
	main.time.paused=true
	if main.end==true:
		lose.play()
		lose.connect("finished",Callable(self,"_on_audio_finished_end"))

func _on_audio_finished_end():
	main.end=false
	main.time.stop()
	Engine.time_scale=0
	

#below this controls movement for the dog character
func _physics_process(_delta):
	if !dog:
		return
	
	var leftright = Input.get_axis("Left", "Right")
	if leftright:
		velocity.x = leftright * SPEED
		dog.flip_h=int(leftright+1)
		dog.flip_v=int(leftright+1)
		dog.rotation=80
		
		skateboard.flip_h=int(leftright+1)
		skateboard.flip_v=int(leftright+1)
		skateboard.rotation=80
		
		dog.play("Moving")
		left = 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		left=80
		
		
		
	var updown = Input.get_axis("Up", "Down")
	if updown:
		velocity.y = updown * SPEED
		dog.flip_v=int(updown+1)
		dog.rotation=0
		
		skateboard.flip_v=int(updown+1)
		skateboard.rotation=0
		dog.play("Moving")
		left=0
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		left =0
		
	#controls the idle animation
	if(Input.is_anything_pressed()==false):
		dog.play("Idle")
	move_and_slide()


#below controls sound and moving particles
func _on_dog_frame_changed():
	if skate.is_playing():
		return
		
	if dog.animation == "Moving":
		skate.play()
		move.emitting=true
		
	if dog.animation == "Idle":
		skate.stop()
		move.emitting=false
