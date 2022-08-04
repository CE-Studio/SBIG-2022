extends Node3D

var player:RigidDynamicBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
    player = $"../Player"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position = player.position
