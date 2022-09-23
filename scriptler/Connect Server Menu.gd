extends Node2D

var client_data = {
    "ip": "127.0.0.1",
    "port": "1261",    
}

onready var ip_address_text: LineEdit = $"%IpAddress"
onready var port_text: LineEdit = $"%Port"
onready var connect_button: Button = $"%Connect"
onready var back_button: Button = $"%Back"

func _ready():
    connect_button.connect("button_down", self, "_connect_button_pressed")
    back_button.connect("button_down", self, "_back_button_pressed")
    
    var file = File.new()
    file.open("res://client_data.res", File.READ)
    client_data = str2var(file.get_as_text())
    file.close()
    
    port_text.text = client_data.port
    ip_address_text.text = client_data.ip

func _connect_button_pressed():
    client_data.ip = ip_address_text.text
    client_data.port = port_text.text
    
    var file = File.new()
    file.open("res://client_data.res", File.WRITE)
    file.store_string(var2str(client_data))
    file.close()
    
    
func _back_button_pressed():
    queue_free()
