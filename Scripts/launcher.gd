extends Area3D

@export var directionAndSrength:Vector3
var bottlestrap:Resource = load("res://scenesAndPrefabs/sodaJet.tscn")
var player:Player
var anim:AnimationPlayer

func _ready():
    player = $"../Player"
    anim = $"anim"
    connect("body_entered", self.body_entered)

func body_entered(body:Node3D):
    if body.name == "Player":
        anim.play("fling")
        player.apply_impulse(directionAndSrength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
