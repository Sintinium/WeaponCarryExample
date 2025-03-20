extends StaticBody2D

@export var weapon_joint: PinJoint2D
@export var click_area: Area2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		_input_mouse(mouse_event)

func _input_mouse(mouse_event: InputEventMouseButton) -> void:
	if mouse_event.is_pressed() and mouse_event.button_index == MOUSE_BUTTON_LEFT:
		# Reset the joint if there's already a weapon connected
		if weapon_joint.node_b:
			weapon_joint.node_b = NodePath("")
			return

		# Loop through the overlapping bodies and if it finds a weapon it connects it to the joint
		if click_area.has_overlapping_bodies():
			var colliders := click_area.get_overlapping_bodies()
			for collider in colliders:
				if collider is BaseWeapon:
					var weapon = collider as BaseWeapon
					weapon_joint.node_b = weapon.get_path()
					return

# Move cursor to mouse position
func _physics_process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	global_position = mouse_position
