extends Area3D

var player:Player

func _ready():
    player = $"../../Player"
    connect("body_entered", self.body_entered)


func _process(delta):
    pass

func body_entered(body:Node3D):
    if body.name == "Player":
        print("zzz")
