extends Node3D

@export var offset:Vector3
var player:Player

# Called when the node enters the scene tree for the first time.
func _ready():
    player = $"/root/game/Player"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    look_at(player.position - offset)
    rotation.x = 0
    rotation.z = 0
