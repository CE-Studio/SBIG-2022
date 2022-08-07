extends Node

const LEVEL_LIST := [ "menu", "rundown", "level1", "level2", "level3" ]
const LVLID_MENU := 0
const LVLID_RUNDOWN := 1
const LVLID_LEVELOFFSET := 2

var current_level := 0

func _ready():
    pass

func _process(delta):
    pass

func load_level_direct(id:int):
    get_tree().change_scene("res://scenesAndPrefabs/" + LEVEL_LIST[id] + ".tscn")

func load_next_level():
    current_level += 1
    reload_current_level()

func reload_current_level():
    get_tree().change_scene("res://scenesAndPrefabs/" + LEVEL_LIST[current_level] + ".tscn")
