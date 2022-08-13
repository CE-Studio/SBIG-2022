extends Area3D

var part2:Node3D
var floora:VoxelTerrain

# Called when the node enters the scene tree for the first time.
func _ready():
    floora = $"/root/game/floor"
    part2 = $"/root/game/part 2"
    part2.set_process(false)
    part2.set_physics_process(false)
    part2.call_deferred("hide")
    connect("body_entered", check)

func check(obj:RigidDynamicBody3D):
    if obj.name == "Player":
        part2.set_process(true)
        part2.set_physics_process(true)
        part2.show()
        floora.call_deferred("hide")
        obj.position = part2.position
