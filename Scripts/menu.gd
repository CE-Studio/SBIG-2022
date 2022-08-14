extends Control

var play_button:TextureButton
var story_button:TextureButton
var options_button:TextureButton
var credits_button:TextureButton
var quit_button:TextureButton
var crawling := false
var storycrawl

var youCant

var manager:GameManager

func _ready():
    youCant = load("res://textures/Screenshot from 2022-08-12 01-59-32.png")
    manager = $"/root/GameManager"
    play_button = $"Play"
    story_button = $"Story"
    options_button = $"Options"
    credits_button = $"Credits"
    quit_button = $"Quit"
    storycrawl = $"/root/menu/Camera3D/Node3D/Sprite3D"
    play_button.connect("pressed", self._press_play)
    story_button.connect("pressed", self._press_story)
    options_button.connect("pressed", self._press_options)
    credits_button.connect("pressed", self._press_credits)
    quit_button.connect("pressed", self._press_quit)

func _process(delta):
    if crawling:
        storycrawl.position.y += (delta / 6)

func _press_play():
    manager.load_level_direct(manager.LVLID_LEVELOFFSET)
    #manager.load_level_direct(8)

func _press_story():
    crawling = true

func _press_options():
    options_button.texture_pressed = youCant
    options_button.texture_normal = youCant
    options_button.texture_hover = youCant
    options_button.texture_focused = youCant
    options_button.texture_disabled = youCant
    options_button.position.y -= 100

func _press_credits():
    pass

func _press_quit():
    get_tree().quit()
