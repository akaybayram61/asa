extends Node2D

var peer: NetworkedMultiplayerPeer = NetworkedMultiplayerENet.new()
var bagli_oyucu_sayisi: int = 0
var server_maks_oyuncu_sayisi: int = 0

onready var oyuncu_sayisi_etiket := $"%oyuncu_sayisi"
onready var server_info := $"%server_info"
onready var lobi := $lobi

func _ready():
    get_tree().connect("network_peer_connected", self, "_player_connected")
    get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
    get_tree().connect("connected_to_server", self, "_connected_ok")
    get_tree().connect("connection_failed", self, "_connected_fail")
    get_tree().connect("server_disconnected", self, "_server_disconnected")    

func _process(delta):
    pass

func setup_server(server_port, max_players):
    # sunucuyu olustur
    server_maks_oyuncu_sayisi = int(max_players)
    peer.create_server(int(server_port), server_maks_oyuncu_sayisi)
    get_tree().network_peer = peer
    server_info.visible = true
    bagli_oyucu_sayisi += 1
    bagli_oyuncu_sayisi_etiket_guncelle()
    # oyuncuyu yerlestir
    
func setup_client(server_ip, server_port):
    peer.create_client(server_ip, int(server_port))
    get_tree().network_peer = peer
    server_info.visible = false

func _player_connected(player_id):
    print("{0} idli oyuncu baglandi.".format([player_id]))
    Utils.create_player(player_id, true, lobi)
    bagli_oyucu_sayisi += 1
    bagli_oyuncu_sayisi_etiket_guncelle()
    
func _player_disconnected(player_id):
    print("{0} idli oyuncunun baglantisi koptu.".format([player_id]))
    var player := lobi.get_node(str(player_id))
    remove_child(player)
    player.queue_free()
    
    bagli_oyucu_sayisi -= 1
    bagli_oyuncu_sayisi_etiket_guncelle()

func _connected_ok():
    print("Sunucuya baglanti basarili.")
    Utils.create_player(get_tree().get_network_unique_id(), false, lobi)
    
func _connected_fail():
    print("Sunucuya baglanilamadi.")

func _server_disconnected():
    print("Sunucu baglantisi koptu.")

func bagli_oyuncu_sayisi_etiket_guncelle():
    oyuncu_sayisi_etiket.text = str(bagli_oyucu_sayisi) + \
                            "/" + \
                            str(server_maks_oyuncu_sayisi)
