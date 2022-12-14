extends Node2D

signal connect_server

var client_data = {
    "ip": "127.0.0.1",
    "port": "1261",    
}

onready var ip_address_text: LineEdit = $"%IpAddress"
onready var port_text: LineEdit = $"%Port"
onready var connect_button: Button = $"%Connect"
onready var back_button: Button = $"%Back"

onready var controller := get_parent()

func _ready():
    connect_button.connect("button_down", self, "_connect_button_pressed")
    back_button.connect("button_down", self, "_back_button_pressed")
    
    var file = File.new()
    var hata = file.open("user://client_data.res", File.READ)
    if hata == OK:
        client_data = str2var(file.get_as_text())
        file.close()
    else:
        file.open("user://client_data.res", File.WRITE)
        file.store_string(var2str(client_data))
        file.close()
    
    port_text.text = client_data.port
    ip_address_text.text = client_data.ip

func _connect_button_pressed():
    client_data.ip = ip_address_text.text
    client_data.port = port_text.text
    
    var file = File.new()
    file.open("user://client_data.res", File.WRITE)
    file.store_string(var2str(client_data))
    file.close()
    emit_signal("connect_server", client_data.ip, client_data.port)
    
    
func _back_button_pressed():
    queue_free()
