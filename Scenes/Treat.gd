extends Node2D

@onready var dog = $/root/Sceneone/Dog/Dog_base2

@onready var eat = $/root/Sceneone/Treats/Area2D/Eat

@export var score_add = 5

#@onready var gone = $Gone

#the items that are collected by the player character

func _on_area_2d_body_entered(body):
	if dog.is_queued_for_deletion():
		return false
	
#below controls the dog score with the treats and also the emittion for the dog eating
	if body.is_in_group("dog"):
		dog.score = dog.score + score_add
		print(dog.score)
		eat.play()
		dog.eat.emitting = true
		call_deferred("free")
