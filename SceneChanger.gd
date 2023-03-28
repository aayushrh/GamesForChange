extends CanvasLayer

func _ready():
	$Dissolve.rect_size.y *= (get_viewport().size.y)
	$Dissolve.rect_size.x *= (get_viewport().size.x)
	$Slide.rect_position.y *= (get_viewport().size.y)/(360*2)
	$Slide.rect_position.x *= (get_viewport().size.x)/(740*2)
	$Slide.rect_scale.y *= (get_viewport().size.y)/(360*2)
	$Slide.rect_scale.x *= (get_viewport().size.x)/(740*2)

func change_scene_to(target):
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene_to(target)
	$AnimationPlayer.play_backwards("dissolve")

func slide_change_scene_to(target):
	$AnimationPlayer.play("slide_start")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene_to(target)
	$AnimationPlayer.play_backwards("slide_end")
	
