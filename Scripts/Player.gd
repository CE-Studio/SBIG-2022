extends RigidDynamicBody3D

class_name Player

var controllable:bool = true
const TORQUE := 45

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    var vec := Input.get_vector("ui_down", "ui_up", "ui_left", "ui_right")
    if controllable:
        apply_torque(Vector3(vec.x * TORQUE, 0, vec.y * TORQUE))
    
    if position.y < -100:
        position = Vector3(0, 5, 0)
        
func set_control_state(state:bool):
    controllable = state
