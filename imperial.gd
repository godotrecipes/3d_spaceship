extends CharacterBody3D

func _ready():
	$Imperial2.get_active_material(0).albedo_texture = load("res://assets/ultimate spaceships - may 2021/Imperial_Red.png")

#func _physics_process(delta):
#	var velocity = -transform.basis.z * 5
#
#	move_and_collide(velocity * delta)
