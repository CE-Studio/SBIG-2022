extends Node3D

var opened := false

# Called when the node enters the scene tree for the first time.
func _ready():
    $"Area3D".connect("body_entered", play)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play(a):
    if a.name == "Player":
        if !opened:
            var h = $"AnimationPlayer"
            h.play("open")
            opened = true
