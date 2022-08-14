extends Control

var play_button:TextureButton
var story_button:TextureButton
var options_button:TextureButton
var credits_button:TextureButton
var quit_button:TextureButton
var crawling := false
var storycrawl
var music_player:AudioStreamPlayer
var credits_open := false
var credits_button_pos
var credits_button_size

var youCant
var credits_button_image
var credits_image

var manager:GameManager

func _ready():
    youCant = load("res://textures/Screenshot from 2022-08-12 01-59-32.png")
    credits_button_image = load("res://textures/buttons/Button_Credits.png")
    credits_image = load("res://textures/Credits.png")
    manager = $"/root/GameManager"
    play_button = $"Play"
    story_button = $"Story"
    options_button = $"Options"
    credits_button = $"Credits"
    quit_button = $"Quit"
    storycrawl = $"/root/menu/Camera3D/Node3D/Sprite3D"
    music_player = $"/root/menu/AudioStreamPlayer2"
    play_button.connect("pressed", self._press_play)
    story_button.connect("pressed", self._press_story)
    options_button.connect("pressed", self._press_options)
    credits_button.connect("pressed", self._press_credits)
    quit_button.connect("pressed", self._press_quit)
    credits_button_pos = credits_button.position
    credits_button_size = credits_button.get_size()

func _process(delta):
    if crawling:
        storycrawl.position.y += (delta / 6)

func _press_play():
    manager.load_level_direct(manager.LVLID_LEVELOFFSET)
    #manager.load_level_direct(8)

func _press_story():
    crawling = true
    music_player.play()

func _press_options():
    _set_button_image(options_button, youCant)
    options_button.position.y -= 100

func _press_credits():
    if credits_open:
        credits_open = false
        _set_button_image(credits_button, credits_button_image)
        credits_button.position = credits_button_pos
        credits_button.set_size(credits_button_size)
    else:
        credits_open = true
        _set_button_image(credits_button, credits_image)
        credits_button.position = Vector2(0, 0)
        credits_button.set_size(get_viewport().get_visible_rect().size)

func _press_quit():
    get_tree().quit()

func _set_button_image(button:TextureButton, newImg:Texture):
    button.texture_pressed = newImg
    button.texture_normal = newImg
    button.texture_hover = newImg
    button.texture_focused = newImg
    button.texture_disabled = newImg
