extends Node2D

onready var quit_button: Button = $"%Quit"
onready var create_server_button: Button = $"%Create Server"
onready var connect_server_button: Button = $"%Connect Server"
onready var player_profile_button: Button = $"%Player Profile"
onready var back_button: Button = $"%BackButton"
onready var controller := get_parent()

var player_profile_menu: PackedScene = preload("res://sahneler/Player Profile Menu.tscn")
var create_server_menu: PackedScene = preload("res://sahneler/Create Server Menu.tscn")
var connect_server_menu: PackedScene = preload("res://sahneler/Connect Server Menu.tscn")
var oyun_nesnesi: PackedScene = preload("res://sahneler/Oyun.tscn")

func _ready():
    quit_button.connect("button_down", self, "_quit")
    create_server_button.connect("button_down", self, "_open_create_server_menu")
    connect_server_button.connect("button_down", self, "_open_connect_server_menu")
    player_profile_button.connect("button_down", self, "_open_player_profile_menu")
    back_button.connect("button_down", self, "_back_button_pressed")
    
func _process(delta):
    pass

func _quit():
    get_tree().quit(0)

func _open_create_server_menu():
    var cratsm := create_server_menu.instance()
    cratsm.connect("start_server", self, "_start_server")
    add_child(cratsm)
    
func _open_connect_server_menu():
    var consm := connect_server_menu.instance()
    consm.connect("connect_server", self, "_connect_server")
    add_child(consm)
    
func _open_player_profile_menu():
    add_child(player_profile_menu.instance())

func _start_server(server_port, max_players):
    var on := oyun_nesnesi.instance()
    controller.add_child(on)
    controller.move_child(on, 0)
    on.setup_server(server_port, max_players)
    
    # server oyuncuyu ekle
    Utils.create_player(1, false, on.get_node("lobi"))
    controller.resume_game()

func _connect_server(server_ip, server_port):
    var on := oyun_nesnesi.instance()
    controller.add_child(on)
    controller.move_child(on, 0)
    on.setup_client(server_ip, server_port)
    controller.resume_game()

func _back_button_pressed():
    controller.resume_game()
