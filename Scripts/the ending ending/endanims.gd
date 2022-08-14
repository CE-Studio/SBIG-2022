extends AnimationPlayer

func _ready():
    connect("animation_finished", next)
    play("end1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func next(a):
    if a == "end1":
        play("end2")
    if a == "end2":
        play("end3")
    if a == "end3":
        play("end4")
    if a == "end4":
        get_tree().quit()
