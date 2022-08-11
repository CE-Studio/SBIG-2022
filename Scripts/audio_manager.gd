extends Node

var game_manager:GameManager

var music:AudioStreamPlayer
var sfx:AudioStreamPlayer

var game_over_music:AudioStream

func _ready():
    game_manager = $"/root/GameManager"
    music = $"Music"
    game_over_music = parse_resource_audio("game_over")
    music.connect("finished", replay)

func _process(_delta):
    for i in range(self.get_child_count() - 1, 0, -1):
        var this_player:AudioStreamPlayer = self.get_child(i)
        if !this_player.playing:
            self.remove_child(this_player)
            
func replay():
    music.play()

func parse_resource_audio(audio_name:String) -> AudioStream:
    #var new_audio:Resource = load("res://sounds/" + audio_name + ".wav")
    #return new_audio.instantiate()
    return load("res://sounds/" + audio_name + ".wav")

func set_music(new_music:AudioStream):
    music.stream = new_music
    music.play()

func silence_music():
    music.stop()

func play_sfx(new_sfx:AudioStream):
    var new_stream_player:AudioStreamPlayer = AudioStreamPlayer.new()
    self.add_child(new_stream_player)
    new_stream_player.stream = new_sfx
    new_stream_player.play()
