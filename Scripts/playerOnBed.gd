extends Area3D

var player:Player
var particle:GPUParticles3D

var particleTimer = 1.0
var endedLevel = false

func _ready():
    player = $"../../Player"
    connect("body_entered", self.body_entered)
    particle = $"GPUParticles3D"
    particle.hide()


func _process(delta):
    if endedLevel && particleTimer > 0.0:
        particleTimer -= delta
        if particleTimer <= 0.0:
            particle.hide()

func body_entered(body:Node3D):
    if body.name == "Player":
        print("Level complete")
        player.set_control_state(false)
        particle.show()
        endedLevel = true
