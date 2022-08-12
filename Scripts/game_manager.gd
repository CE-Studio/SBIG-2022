extends Node

const LEVEL_LIST := ["game", "menu", "rundown", "level1", "level2", "level3", "level4"]
const FLOOR_TYPE := [0, 0, 0, 0, 0, 0, 0]
const WALL__TYPE := [0, 0, 0, 0, 0, 0, 0]
const LVLID_MENU := 1
const LVLID_RUNDOWN := 2
const LVLID_LEVELOFFSET := 3
const SLEEP_LEVEL_MAX := 100

var current_level := LVLID_MENU
var current_floor:int = FLOOR_TYPE[LVLID_MENU]
var current_wall:int = WALL__TYPE[LVLID_MENU]
var current_sleep := SLEEP_LEVEL_MAX

var sleepy_meter:Label
var is_game_over := false
var game_over_resource:Resource = load("res://scenesAndPrefabs/GameOverPopup.tscn")
var game_over_popup:TextureRect
var game_over_origin:Vector2
const GAMEOVER_RANDOM_EXTREMES := Vector2(10.0, 10.0)
var player:Player
var audio:Node
#var audio_prefab:Resource = load("res://scenesAndPrefabs/AudioParent.tscn")

var rng := RandomNumberGenerator.new()

var prop_wakeup_table = {
    "glass": Vector2i(10, 30),
    "figure": Vector2i(5, 15)
}

func _ready():
    sleepy_meter = Label.new()
    sleepy_meter.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
    sleepy_meter.position.y -= 20
    add_child(sleepy_meter)
    sleepy_meter.text = "" + str(current_sleep) + "/" + str(SLEEP_LEVEL_MAX) + " sleepy"
    rng.randomize()

func _process(_delta):
    if is_game_over:
        game_over_popup.position = Vector2(
            game_over_origin.x + randf_range(-GAMEOVER_RANDOM_EXTREMES.x, GAMEOVER_RANDOM_EXTREMES.x),
            game_over_origin.y + randf_range(-GAMEOVER_RANDOM_EXTREMES.y, GAMEOVER_RANDOM_EXTREMES.y))
    if (Input.get_action_raw_strength("game_restart") > 0.5) && (current_level >= LVLID_LEVELOFFSET):
        reload_current_level()
    if (Input.get_action_raw_strength("ui_cancel") > 0.5) && (current_level >= LVLID_LEVELOFFSET):
        load_level_direct(LVLID_MENU)

func load_level_direct(id:int):
    current_level = id
    reload_current_level()

func load_next_level():
    current_level += 1
    reload_current_level()

func reload_current_level():
    is_game_over = false
    current_floor = FLOOR_TYPE[current_level]
    current_wall = WALL__TYPE[current_level]
    max_sleep()
    get_tree().change_scene("res://scenesAndPrefabs/" + LEVEL_LIST[current_level] + ".tscn")

func max_sleep():
    current_sleep = SLEEP_LEVEL_MAX
    sleepy_meter.text = "" + str(current_sleep) + "/" + str(SLEEP_LEVEL_MAX) + " sleepy"

func decrease_sleep(prop:String):
    print(prop)
    var trimmed_prop:String = prop.replace(".tscn", "").replace("_", "").to_lower()
    var this_range:Vector2i = prop_wakeup_table[trimmed_prop]
    current_sleep -= randi_range(this_range.x, this_range.y)
    sleepy_meter.text = "" + str(current_sleep) + "/" + str(SLEEP_LEVEL_MAX) + " sleepy"
    if current_sleep <= 0:
        game_over_popup = game_over_resource.instantiate()
        get_node("/root/" + str(get_tree().current_scene.name)).add_child(game_over_popup)
        if game_over_origin == null:
            game_over_origin = game_over_popup.position
        player.controllable = false
        is_game_over = true
        audio.set_music(audio.game_over_music)
