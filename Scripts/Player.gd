extends RigidDynamicBody3D

class_name Player

var manager:GameManager
var controllable:bool = true
const TORQUE := 45

# Called when the node enters the scene tree for the first time.
func _ready():
    manager = $"/root/GameManager"
    print(get_tree().current_scene.name)
    #if get_tree().current_scene.name == "game":
    #    manager.load_level_direct(manager.LVLID_LEVELOFFSET)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
    var vec := Input.get_vector("ui_down", "ui_up", "ui_left", "ui_right")
    var vec2 = Input.get_axis("game_rright", "game_rleft")
    if controllable:
        apply_torque(Vector3(vec.x * TORQUE, vec2 * TORQUE, vec.y * TORQUE))
    
    if position.y < -100:
        manager.reload_current_level()
        
func set_control_state(state:bool):
    controllable = state
