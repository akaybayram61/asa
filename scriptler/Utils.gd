extends Node

onready var player_scene := preload("res://sahneler/Player.tscn")
onready var remote_player_scene := preload("res://sahneler/RemotePlayer.tscn")
onready var real_player_scene := preload("res://sahneler/RealPlayer.tscn")

func create_player(player_id, is_remote, lobi):
    var controller: Controller
    if is_remote:
        controller = remote_player_scene.instance()
    else:
        controller = real_player_scene.instance()
        
    var player := player_scene.instance()
    
    player.add_child(controller)
    # eger oyuncu icinden controller a erismek istersek
    # bu isim ile erisebiliriz
    controller.name = "controller"
    # oyuncu ismini id yapiyoruz
    player.name = str(player_id)
    # oyuncuyu lobiye ekliyoruz
    lobi.add_child(player)
    #oyuncuyu baslangic noktasina tasiyoruz
    player.position = lobi.get_node("start").position
    # eger gercek oyuncu ise kamerasini seciyoruz
    # kameranin hareket etmesi simdilik mantikli degil
    # controller.get_node("Camera").current = !is_remote
