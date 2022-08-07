extends RigidDynamicBody3D

var manager:GameManager
var _has_hit_floor := false

func _ready():
    manager = $"/root/GameManager"
    connect("body_entered", self.body_entered)

func _process(delta):
    pass

func body_entered(body:Node3D):
    if "Floor" in body.name && !_has_hit_floor:
        _has_hit_floor = true
        manager.decrease_sleep(self.name)
