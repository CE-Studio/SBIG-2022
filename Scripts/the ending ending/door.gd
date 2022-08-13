extends AnimatableBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
    $"Area3D".connect("body_entered", play)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play(a):
    if a.name == "Player":
        var h = $"AnimationPlayer"
        h.play("open")
