extends Control

var play_button:TextureButton
var story_button:TextureButton
var options_button:TextureButton
var credits_button:TextureButton
var quit_button:TextureButton

var manager:GameManager

func _ready():
    manager = $"/root/GameManager"
    play_button = $"Play"
    story_button = $"Story"
    options_button = $"Options"
    credits_button = $"Credits"
    quit_button = $"Quit"
    play_button.connect("pressed", self._press_play)
    story_button.connect("pressed", self._press_story)
    options_button.connect("pressed", self._press_options)
    credits_button.connect("pressed", self._press_credits)
    quit_button.connect("pressed", self._press_quit)

func _process(_delta):
    pass

func _press_play():
    manager.load_level_direct(manager.LVLID_LEVELOFFSET)

func _press_story():
    pass

func _press_options():
    pass

func _press_credits():
    pass

func _press_quit():
    get_tree().quit()
