extends Node3D


@onready var animation_player = $AnimationPlayer

func shake():
	animation_player.play("shake")
