extends Node2D

const SERVER_PORT: int = 1261
const MAX_PLAYERS: int = 10

var server_ip: String = "127.0.0.1"

var peer: NetworkedMultiplayerPeer = NetworkedMultiplayerENet.new()

func _ready():
    get_tree().connect("network_peer_connected", self, "_player_connected")
    get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
    get_tree().connect("connected_to_server", self, "_connected_ok")
    get_tree().connect("connection_failed", self, "_connected_fail")
    get_tree().connect("server_disconnected", self, "_server_disconnected")    

func _process(delta):
    pass

func setup_server():
    peer.create_server(SERVER_PORT, MAX_PLAYERS)
    get_tree().network_peer = peer

func setup_client():
    peer.create_client(server_ip, SERVER_PORT)
    get_tree().network_peer = peer

func _player_connected():
    print("Bir oyuncu baglandi.")
    
func _player_disconnected():
    print("Bir oyuncunun baglantisi koptu.")

func _connected_ok():
    print("Sunucuya baglanti basarili.")
    
func _connected_fail():
    print("Sunucuya baglanilamadi.")

func _server_disconnected():
    print("Sunucu baglantisi koptu.")
