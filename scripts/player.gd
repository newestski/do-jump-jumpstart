class_name Player
extends CharacterBody2D

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const CYOTEE_TIME := 0.1

var is_dead = false
var time_in_air = 0

func ready():
	pass
	

func _physics_process(delta: float) -> void:
	#check if dead
	if is_dead:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		time_in_air += delta
	else:
		time_in_air = 0
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and time_in_air <= CYOTEE_TIME:
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func explode_violently():
	print("ow i died")
	$AudioExplosion.play()
	cpu_particles_2d.emitting = true
	sprite_2d.visible = false
	is_dead = true
