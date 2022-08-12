extends RigidDynamicBody3D

var manager:GameManager
var _has_hit_floor := false
@export var myname:String
var aud:AudioStreamPlayer

func _ready():
    manager = $"/root/GameManager"
    aud = $"AudioStreamPlayer"
    connect("body_entered", self.body_entered)

#func _process(delta):
#    pass

func body_entered(body:Node3D):
    if ("floor" in body.name) && !_has_hit_floor:
        _has_hit_floor = true
        aud.play()
        manager.decrease_sleep(myname)
