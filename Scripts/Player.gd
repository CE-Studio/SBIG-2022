extends RigidDynamicBody3D

class_name Player

var manager:GameManager
var controllable:bool = true
const TORQUE := 45
var audio_prefab:Resource = load("res://scenesAndPrefabs/AudioParent.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    manager = $"/root/GameManager"
    manager.player = self
    manager.audio = audio_prefab.instantiate()
    get_node("/root/" + str(get_tree().current_scene.name)).call_deferred("add_child", manager.audio)

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
