extends Control

class DebugVector:
	var object  # The node to follow
	var property  # The property to draw
	var scale  # Scale factor
	var width  # Line width
	var color  # Draw color
	
	func _init(_object, _property, _scale, _width, _color):
		object = _object
		property = _property
		scale = _scale
		width = _width
		color = _color
		
	func draw(node, camera):
		var start = camera.unproject_position(object.global_transform.origin)
		var end = camera.unproject_position(object.global_transform.origin + object.get(property) * scale)
		node.draw_line(start, end, color, width)
		node.draw_triangle(end, start.direction_to(end), width * 2, color)
		
var vectors = []  # Array to hold all registered values

func _process(delta):
	if not visible:
		return
	queue_redraw()
	
func _draw():
	if vectors.size() == 0:
		return
	var camera = get_viewport().get_camera_3d()
	for vector in vectors:
		vector.draw(self, camera)

func add_vector(object, property, scale=1, width=4, color=Color(1, 1, 1, 1)):
	vectors.append(DebugVector.new(object, property, scale, width, color))

func remove_vector(object, property):
	for vector in vectors:
		if vector.object == object and vector.property == property:
			vectors.erase(vector)
			
func draw_triangle(pos, dir, size, color):
	var a = pos + dir * size
	var b = pos + dir.rotated(2*PI/3) * size
	var c = pos + dir.rotated(4*PI/3) * size
	var points = PackedVector2Array([a, b, c])
	draw_polygon(points, PackedColorArray([color]))
