extends Node2D

onready var save_button = $"%Save"
onready var back_button = $"%Back"
onready var nickname_box = $"%Player Name"
onready var color_box: OptionButton = $"%Player Color"

var player_data = {
    "nickname": "Player",
    "color": "White",
}

var player_colors = [
    "White",
    "Blue",
    "Red",
    "Green",
    "Purple",
    "Magenta",
    "Pink",
]

func _ready():
    var file = File.new()
    var hata = file.open("user://player_data.res", File.READ)
    if OK == hata:
        player_data = str2var(file.get_as_text())
        file.close()
    else:
        file.open("user://player_data.res", File.WRITE)
        file.store_string(var2str(player_data))
        file.close()
    
    save_button.connect("button_down", self, "_save_button")
    back_button.connect("button_down", self, "_back_button")
    
    color_box.add_item("White", 0)
    color_box.add_item("Blue", 1)
    color_box.add_item("Red", 2)
    color_box.add_item("Green", 3)
    color_box.add_item("Purple", 4)
    color_box.add_item("Magenta", 5)
    color_box.add_item("Pink", 6)
    
    nickname_box.text = player_data.nickname
    color_box.select(player_colors.find(player_data.color))
    

func _process(delta):
    pass

func _save_button():
    player_data.nickname = nickname_box.text
    var player_color_id = color_box.selected
    player_data.color = player_colors[player_color_id]
    
    # save player data
    var file = File.new()
    file.open("user://player_data.res", File.WRITE)
    file.store_string(var2str(player_data))
    file.close()
    
    
func _back_button():
    queue_free()
