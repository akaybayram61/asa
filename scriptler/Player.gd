extends KinematicBody2D
# oyuncu collision sekli golgesi haline getirildi

export(int) var speed = 180.0

enum {UP, DOWN, RIGHT, LEFT}
enum {RUN, ATTACK, IDLE}
var state := IDLE

var commands = [ 0.0, 0.0, 0.0, 0.0 ]

# ileride animasyon icin lazim olacak
# onready var animation_player := $AnimationPlayer
onready var sprite := $Sprite
onready var controller := get_node("controller")

func _process(delta):
    # oyuncu durum makinesi ile kontrol edilirse uzak oyuncularin
    # yonetilmesi daha kolay olacak
    match state:
        RUN:
            run_state()
        ATTACK:
            attack_state()
        IDLE:
            idle_state()


func _physics_process(delta):
    var input_vector = Vector2.ZERO
# Bu kisim Controller isimli sahneye tasinacak. Oynayan oyuncunun 
# ekrandaki tum oyunculari hareket ettirmemesi icin
#    input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#    input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    input_vector.x = commands[RIGHT] - commands[LEFT]
    input_vector.y = commands[DOWN] - commands[UP]
    input_vector = input_vector.normalized()
    
    if controller.has_method("is_player"):
        rpc_unreliable("network_update", position)
        
    move_and_slide(input_vector * speed)
    
    
#	if input_vector == Vector2.ZERO:
#		$AnimationTree.get("parameters/playback").travel("Idle")
#	else:
#		$AnimationTree.get("parameters/playback").travel("Walk")
#		move_and_slide(input_vector * speed)
#		$AnimationTree.set("parameters/Idle/blend_position", input_vector)
#		$AnimationTree.set("parameters/Walk/blend_position", input_vector)
#
#	OnScreenKeyboard.set_on_screen_input_vector(input_vector)

func run_state():
    pass
    
func attack_state():
    pass
    
func idle_state():
    pass

sync func network_update(pos):
    position = pos
