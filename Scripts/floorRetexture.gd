extends MeshInstance3D

const _floorid = ["res://textures/floors/floorMat0.tres", "res://textures/floors/floorMat1.tres",
                  "res://textures/floors/floorMat2.tres", "res://textures/floors/floorMat3.tres"]

# Called when the node enters the scene tree for the first time.
func _ready():
    var h:GameManager = $"/root/GameManager"
    var i:StandardMaterial3D = load(_floorid[h.current_floor])
    material_override = i
