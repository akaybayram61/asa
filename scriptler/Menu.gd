extends Node2D

var ip_address: String = "127.0.0.1"

onready var quit_button: Button = $"%Quit"
onready var create_server_button: Button = $"%Create Server"
onready var connect_server_button: Button = $"%Connect Server"
onready var player_profile_button: Button = $"%Player Profile"

var player_profile_menu: PackedScene = preload("res://sahneler/Player Profile Menu.tscn")
var create_server_menu: PackedScene = preload("res://sahneler/Create Server Menu.tscn")
var connect_server_menu: PackedScene = preload("res://sahneler/Connect Server Menu.tscn")

func _ready():
    quit_button.connect("button_down", self, "_quit")
    create_server_button.connect("button_down", self, "_open_create_server_menu")
    connect_server_button.connect("button_down", self, "_open_connect_server_menu")
    player_profile_button.connect("button_down", self, "_open_player_profile_menu")
    
func _process(delta):
    pass

func _quit():
    get_tree().quit(0)

func _open_create_server_menu():
    add_child(create_server_menu.instance())
    
func _open_connect_server_menu():
    add_child(connect_server_menu.instance())
    
func _open_player_profile_menu():
    add_child(player_profile_menu.instance())
