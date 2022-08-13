extends Node3D

var w1
var w2
var w3
var w4

# Called when the node enters the scene tree for the first time.
func _ready():
    w1 = $"wheel"
    w2 = $"wheel2"
    w3 = $"wheel3"
    w4 = $"wheel4"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    w1.rotation.z = position.z
    w2.rotation.z = position.z
    w3.rotation.z = position.z
    w4.rotation.z = position.z
