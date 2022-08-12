extends MeshInstance3D

var cbot:Node3D
var cpart:GPUParticles3D
var play:Player

var timer := 5.0
var launch := false
@export var jettime:float
var aud

var rng := RandomNumberGenerator.new()

func _ready():
    cbot = $"Cola"
    cpart = $"Cola/GPUParticles3D"
    aud = $"AudioStreamPlayer"
    play = get_parent()
    rng.randomize()
    
func _physics_process(delta):
    if launch:
        cbot.position = Vector3(rng.randf_range(-0.1, 0.1), 0.45 + rng.randf_range(-0.1, 0.1), 0.487 + rng.randf_range(-0.1, 0.1))
        timer -= delta
        if timer <= 0:
            cpart.show()
            play.axis_lock_angular_x = true
            play.axis_lock_angular_y = true
            play.axis_lock_angular_z = true
            play.apply_force(global_transform.basis.y * 100)
            if !aud.playing:
                aud.play()
            if timer <= -jettime:
                play.axis_lock_angular_x = false
                play.axis_lock_angular_y = false
                play.axis_lock_angular_z = false
                play.remove_child(self)
        
func _input(event):
    if event.is_action_pressed("ui_accept"):
        launch = true
