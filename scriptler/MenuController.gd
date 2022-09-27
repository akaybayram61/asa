extends Node2D

onready var pause_menu: Node2D = $"%Menu"
onready var in_game_menu: Node2D = $"%Gui"
onready var back_button : Button = $"%BackButton"

func _ready():
	$Gui/PauseButton.connect("button_down", self, "_pause_menu")
	open_menu(false)
	
func _process(delta):
	pass

func _pause_menu():
	open_menu(true)
	
func open_menu(show_back_button: bool):
	in_game_menu.visible = false
	pause_menu.visible = true
	back_button.visible = show_back_button

func resume_game():
	pause_menu.visible = false
	back_button.visible = false
	in_game_menu.visible = true

