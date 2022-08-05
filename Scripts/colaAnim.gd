extends Node3D

var timer := 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    timer += delta
    position.y = sin(timer * PI) / 5
    rotation.y = timer
