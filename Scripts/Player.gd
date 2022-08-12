extends RigidDynamicBody3D

class_name Player

var manager:GameManager
var controllable:bool = true
const TORQUE := 45
var audio_prefab:Resource = load("res://scenesAndPrefabs/AudioParent.tscn")
var sfxp:AudioStreamPlayer
var aud := [load("res://sounds/phys/qubodupPunch01.ogg"),
            load("res://sounds/phys/qubodupPunch02.ogg"),
            load("res://sounds/phys/qubodupPunch03.ogg"),
            load("res://sounds/phys/qubodupPunch04.ogg"),
            load("res://sounds/phys/qubodupPunch05.ogg")]

# Called when the node enters the scene tree for the first time.
func _ready():
    manager = $"/root/GameManager"
    manager.player = self
    manager.audio = audio_prefab.instantiate()
    sfxp = $"AudioStreamPlayer"
    get_node("/root/" + str(get_tree().current_scene.name)).call_deferred("add_child", manager.audio)
    connect("body_entered", psound)
    $"ThighL/RigidDynamicBody3D".connect("body_entered", psound)
    $"ThighR/RigidDynamicBody3D".connect("body_entered", psound)
    $"UpperarmL/RigidDynamicBody3D".connect("body_entered", psound)
    $"UpperarmR/RigidDynamicBody3D".connect("body_entered", psound)
    $"Head/RigidDynamicBody3D".connect("body_entered", psound)

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
    
func psound(a):
    if "floor" in a.name:
        aud.shuffle()
        sfxp.stream = aud[0]
        sfxp.play()
