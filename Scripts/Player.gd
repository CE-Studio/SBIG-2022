extends RigidDynamicBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    var vec := Input.get_vector("ui_down", "ui_up", "ui_left", "ui_right")
    apply_torque(Vector3(vec.x * 30, 0, vec.y  * 30))
    
    if position.y < -100:
        position = Vector3(0, 5, 0)
