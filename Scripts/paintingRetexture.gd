extends MeshInstance3D

const imgs = ["res://textures/pics/paintMat0.tres", "res://textures/pics/paintMat1.tres",
              "res://textures/pics/paintMat2.tres", "res://textures/pics/paintMat3.tres"]

func _ready():
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    material_override = load(imgs[rng.randi_range(0, 3)])
