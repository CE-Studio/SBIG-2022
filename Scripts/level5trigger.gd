extends Area3D

var reveal_wall_l:MeshInstance3D
var reveal_wall_r:MeshInstance3D
var fall_particles:GPUParticles3D
var player:Player
var music:AudioStreamPlayer
var cam:Camera3D
var enviro:WorldEnvironment
var entire_bottom_section:Node3D

var trigger_timer := 0.0
var has_triggered_fall := false
var cam_original_orientation:Vector3

func _ready():
    connect("body_entered", self.body_entered)
    reveal_wall_l = $"../RevealWallL"
    reveal_wall_r = $"../RevealWallR"
    fall_particles = $"../../FallParticles"
    player = $"../../Player"
    music = $"../../AudioStreamPlayer"
    cam = $"../../campoint/Camera3D"
    enviro = $"../../WorldEnvironment"
    entire_bottom_section = $"../../BottomPart"
    fall_particles.emitting = false
    enviro.environment.volumetric_fog_enabled = false
    entire_bottom_section.visible = false
    cam_original_orientation = Vector3(cam.rotation.x, cam.position.x, cam.fov)

func _process(delta):
    if has_triggered_fall:
        trigger_timer += delta
        if trigger_timer >= 4:
            reveal_wall_l.position.x += 10 * delta
            reveal_wall_r.position.x -= 10 * delta
            cam.rotate_x(0.0125 * delta)
            cam.position.x -= (0.25 * delta)
            if !entire_bottom_section.visible:
                entire_bottom_section.visible = true
                enviro.environment.volumetric_fog_enabled = true
        fall_particles.global_position = Vector3(0, player.global_position.y - 30,
            player.global_position.z + (15 if trigger_timer > 4 else 0))
        cam.fov += delta
        if trigger_timer >= 33.85:
            enviro.environment.volumetric_fog_emission_energy += delta
        if trigger_timer >= 35.85:
            has_triggered_fall = false
            fall_particles.emitting = false
            enviro.environment.volumetric_fog_enabled = false
            cam.rotation.x = cam_original_orientation.x
            cam.position.x = cam_original_orientation.y
            cam.fov = cam_original_orientation.z
            player.position = Vector3(-5, 3001, 2.025)
            entire_bottom_section.visible = false
            music.stop()

func body_entered(body:Node3D):
    if body.name == "Player" && !has_triggered_fall:
        has_triggered_fall = true
        fall_particles.emitting = true
        music.play()
