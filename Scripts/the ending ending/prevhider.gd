extends Area3D

@export var toHide:String

# Called when the node enters the scene tree for the first time.
func _ready():
    connect("body_entered", col)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func col(a):
    if a.name == "Player":
        get_node(toHide).hide()
