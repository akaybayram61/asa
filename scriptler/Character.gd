extends KinematicBody2D

enum {UP, DOWN, RIGHT, LEFT}
enum {RUN, ATTACK, IDLE}

var movement := Vector2.ZERO
var state := IDLE

var commands = [ 0.0, 0.0, 0.0, 0.0 ]

onready var animation_player := $AnimationPlayer
onready var sprite := $Sprite

func _ready():
    pass

func _process(delta):
    movement.x = commands[RIGHT] - commands[LEFT]
    movement.y = commands[DOWN] - commands[UP]
    movement = movement.normalized()
    
    if movement != Vector2.ZERO:
        state = RUN
    else:
        state = IDLE
        
    sprite.flip_h = (movement.x < 0)
        
    match state:
        IDLE:
            idle_state(delta)
        RUN:
            run_state(delta)
        ATTACK:
            attack_state(delta)

func _physics_process(delta):
    pass

func idle_state(delta):
    pass

func run_state(delta):
    pass
    
func attack_state(delta):
    pass
