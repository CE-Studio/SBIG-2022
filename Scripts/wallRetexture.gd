extends MeshInstance3D

const _wallid = ["res://textures/wallMat0.tres", "res://textures/wallMat1.tres"]

# Called when the node enters the scene tree for the first time.
func _ready():
    var h:GameManager = $"/root/GameManager"
    var i:StandardMaterial3D = load(_wallid[h.current_wall])
    material_override = i
