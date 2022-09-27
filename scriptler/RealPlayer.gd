extends Controller

func _ready():
    pass

func _process(delta):
    player.commands[RIGHT] = Input.get_action_strength("ui_right")
    player.commands[LEFT] = Input.get_action_strength("ui_left")
    player.commands[UP] = Input.get_action_strength("ui_up")
    player.commands[DOWN] = Input.get_action_strength("ui_down")
