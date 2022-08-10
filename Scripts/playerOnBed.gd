extends Area3D

var player:Player
var particle:GPUParticles3D
var endLevelAnim:AnimationPlayer
var endLevelTexture:TextureRect
var rng := RandomNumberGenerator.new()
var manager:GameManager

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
        particle.show()
        endedLevel = true
        endLevelTexture.show()
        endLevelAnim.play(endLevelAnimNames[rng.randi_range(0, 4)])
