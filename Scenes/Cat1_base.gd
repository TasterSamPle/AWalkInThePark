extends CharacterBody2D

@onready var progress = $/root/Sceneone/Cats/Cat/Path2D/PathFollow2D
@onready var progress2 =$/root/Sceneone/Cats/Cat2/Path2D/PathFollow2D
@onready var progress3 =$/root/Sceneone/Cats/Cat3/Path2D/PathFollow2D
@onready var time=$/root/Sceneone/Level_Time
@onready var cat = $CatAnim
@onready var area=$Area2D
@onready var dog = $/root/Sceneone/Dog/Dog_base2
@onready var damage=$/root/Sceneone/Cats/Cat/Damage

func _process(_delta):
	#control the enemy cats movement and sets them to be inactive if timer is void
	if (!time.paused): 
		progress.progress = progress.progress + 0.25
		progress2.progress = progress2.progress + 0.25
		progress3.progress = progress3.progress - 0.25
		cat.play("Walk")

#below controls damage to the dog
func _on_area_2d_body_entered(body):
	if body.is_in_group("dog"):
		dog.lives = dog.lives - 1
		damage.play()
		print(dog.lives)
		
