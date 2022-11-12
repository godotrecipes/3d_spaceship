extends MarginContainer

class Property:
	var num_format = "%4.2f"
	var object  # The object being tracked
	var property  # the property to display (NodePath)
	var label_ref  # A reference to the Label node.
	var mode  # Display option (rounded, etc).
		
	func _init(_object, _property, _label, _mode):
		object = _object
		property = _property
		label_ref = _label
		mode = _mode
	
	func update_label():
		# Set the label's text
		var s = str(object.name) + "/" + property + " : "
		var p = object.get_indexed(property)
		match mode:
			"":
				s += str(p)
			"length":
				s += num_format % p.length()
			"round":
				match typeof(p):
					TYPE_INT, TYPE_FLOAT:
						s += num_format % p
					TYPE_VECTOR2, TYPE_VECTOR3:
						s += str(p.round())
		label_ref.text = s
		
var properties = []  # Array of the tracked properties.

func _process(delta):
	if not visible:
		return
	for prop in properties:
		prop.update_label()

func add_property(object, property, mode):
	var label = load("res://debug_overlay/debug_label.tscn").instantiate()
	$VBoxContainer.add_child(label)
	properties.append(Property.new(object, property, label, mode))
	
func remove_property(object, property):
	for prop in properties:
		if prop.object == object and prop.property == property:
			prop.label.queue_free()
			properties.erase(prop)
