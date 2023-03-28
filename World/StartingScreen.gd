extends Node2D

func _on_TouchScreenButton_pressed():
	SceneChanger.change_scene_to(load("res://World/World.tscn"))
