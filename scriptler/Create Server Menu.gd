extends Node2D

signal start_server

onready var controller := get_parent()
onready var server_port_text: LineEdit = $"%ServerPort"
onready var max_player_text: LineEdit = $"%MaxPlayer"
onready var create_server_button: Button = $"%CreateServer"
onready var back_button: Button = $"%Back"

var server_data = {
    "port": "1261",
    "max_player": "10",    
}

func _ready():
    var file = File.new()
    var hata = file.open("user://server_data.res", File.READ)
    
    if hata == OK:
        server_data = str2var(file.get_as_text())
        file.close()
    else:
        file.open("user://server_data.res", File.WRITE)
        file.store_string(var2str(server_data))
        file.close()
    
    create_server_button.connect("button_down", self, "_create_server_button_pressed")
    back_button.connect("button_down", self, "_back_button_pressed")
    
    server_port_text.text = server_data.port
    max_player_text.text = server_data.max_player
    
func _create_server_button_pressed():
    server_data.port = server_port_text.text
    server_data.max_player = max_player_text.text
    
    var file = File.new()
    file.open("user://server_data.res", File.WRITE)
    file.store_string(var2str(server_data))
    file.close()
    emit_signal("start_server", server_data.port, server_data.max_player)
    queue_free()
    
func _back_button_pressed():
    queue_free()
