extends CharacterBody2D


@export var WALKSPEED : float = 80.0
@export var RUNSPEED : float = 130.0
@export var JUMP_VELOCITY : float = -200.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animationLock : bool = false
var direction : float = 0.0
var inAir : bool = false

func _physics_process(delta):
	# ========== Physics ===========
	if is_on_floor():
		if inAir == true:
			animated_sprite.play("jump_end")
		inAir = false
	else:
		velocity.y += gravity * delta
		
		
	# ========== Jump =============
	if (Input.is_action_just_pressed("char_jump") or Input.is_action_just_pressed("char_up")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		inAir = true
		animationLock = true
		animated_sprite.play("jump_start")
		

	# ========== Walk and run ============
	direction = Input.get_axis("char_left", "char_right")
	if direction:
		if Input.is_action_pressed("char_run"):
			velocity.x = direction * RUNSPEED
		else:
			velocity.x = direction * WALKSPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALKSPEED)

	move_and_slide()
	update_animation()

func update_animation():
	if not animationLock:
		if direction != 0:
			if Input.is_action_pressed("char_run"):
				animated_sprite.play("run")
			else:
				animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
				
			


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "jump_start":
		animated_sprite.play("jump_normal")
	if animated_sprite.animation == "jump_end":
		animationLock = false;
		
