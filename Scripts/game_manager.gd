extends Node

const LEVEL_LIST := [ "menu", "rundown", "level1", "level2", "level3" ]
const FLOOR_TYPE := [0, 0, 0, 0, 0]
const WALL__TYPE := [0, 0, 0, 0, 0]
const LVLID_MENU := 0
const LVLID_RUNDOWN := 1
const LVLID_LEVELOFFSET := 2
const SLEEP_LEVEL_MAX := 100

var current_level := LVLID_MENU
var current_floor:int = FLOOR_TYPE[LVLID_MENU]
var current_wall:int = WALL__TYPE[LVLID_MENU]
var current_sleep := SLEEP_LEVEL_MAX

var rng := RandomNumberGenerator.new()

var prop_wakeup_table = {
    "glass": Vector2i(5, 15)
}

func _ready():
    rng.randomize()

func load_level_direct(id:int):
    current_level = id
    reload_current_level()

func load_next_level():
    current_level += 1
    reload_current_level()

func reload_current_level():
    current_floor = FLOOR_TYPE[current_level]
    current_wall = WALL__TYPE[current_level]
    max_sleep()
    get_tree().change_scene("res://scenesAndPrefabs/" + LEVEL_LIST[current_level] + ".tscn")

func max_sleep():
    current_sleep = SLEEP_LEVEL_MAX

func decrease_sleep(prop:String):
    var trimmed_prop:String = prop.replace(".tscn", "").replace("_", "").to_lower()
    var this_range:Vector2i = prop_wakeup_table[trimmed_prop]
    current_sleep -= randi_range(this_range.x, this_range.y)
    if current_sleep <= 0:
        pass # Game over code here
