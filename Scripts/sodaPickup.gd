extends Area3D

var bottlestrap:Resource = load("res://scenesAndPrefabs/sodaJet.tscn")
var player:Player

func _ready():
    player = $"../Player"
    connect("body_entered", self.body_entered)

func body_entered(body:Node3D):
    if body.name == "Player":
        var newbot:Node3D = bottlestrap.instantiate()
        newbot.set_name("sodaJet")
        player.add_child(newbot)
        newbot.position = Vector3.ZERO
        newbot.rotation = Vector3.ZERO
        get_parent().remove_child(self)
