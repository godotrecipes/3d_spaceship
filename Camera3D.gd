extends Camera3D

@export var lerp_speed = 3.0
@export var target_path : NodePath
@export var offset = Vector3.ZERO

var target = null

func _ready():
	if target_path:
		target = get_node(target_path)
		
func _physics_process(delta):
	if !target:
		return
		
	var target_pos = target.global_transform.translated_local(offset).origin
	global_transform.origin = global_transform.origin.lerp(target_pos, lerp_speed * delta)
	
#	look_at(target.global_transform.origin, target.transform.basis.y)
	
	var new_basis = global_transform.looking_at(target.global_transform.origin, target.transform.basis.y)
	global_transform = global_transform.interpolate_with(new_basis, lerp_speed * delta)
