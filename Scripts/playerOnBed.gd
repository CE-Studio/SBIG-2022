extends Area3D

var player:Player
var particle:GPUParticles3D
var endLevelAnim:AnimationPlayer
var endLevelTexture:TextureRect
var rng := RandomNumberGenerator.new()
var manager:GameManager
var sfx:AudioStreamPlayer

var particleTimer := 1.0
var endedLevel := false
var endLevelAnimNames := [ "LC_InFromLeft",
    "LC_InFromRight",
    "LC_InFromTop",
    "LC_InFromBottom",
    "LC_SpinFadeIn" ]

func _ready():
    particle = $"GPUParticles3D"
    particle.hide()
    manager = $"/root/GameManager"
    player = $"../../Player"
    connect("body_entered", self.body_entered)
    endLevelAnim = $"../../AnimationPlayer"
    endLevelTexture = $"../../AnimationPlayer/TextureRect"
    sfx = $"AudioStreamPlayer"
    if player == null:
        player = $"/root/game/Player"
        endLevelAnim = $"/root/game/AnimationPlayer"
        endLevelTexture = $"/root/game/AnimationPlayer/TextureRect"
    endLevelTexture.hide()
    rng.randomize()

func _process(delta):
    if endedLevel:
        particleTimer -= delta
        if particleTimer <= 0.0:
            particle.hide()
        if particleTimer <= -1.0:
            manager.load_next_level()
            particleTimer = 200

func body_entered(body:Node3D):
    if body.name == "Player" && !endedLevel:
        print("Level complete")
        player.set_control_state(false)
        endedLevel = true
        if manager.current_level == 8:
            particleTimer = 7
            $"/root/game/campoint/Camera3D/AnimationPlayer".play("beginning of the end")
        else:
            particle.show()
            endLevelTexture.show()
            sfx.play()
            endLevelAnim.play(endLevelAnimNames[rng.randi_range(0, 4)])
