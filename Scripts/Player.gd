extends KinematicBody2D


var speed = 0
export (int) var walk = 200
export (int) var sprint = 300
var mageBall = preload("res://Prefabs/MageBall.tscn")
var canFire = false
var firing = false
onready var anim = get_node("AnimatedSprite")

var velocity = Vector2()
var direction = 1

func _ready():
	canFire = true

func getInput():
	velocity = Vector2()
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("sprint"):
		speed = sprint
		anim.speed_scale = 1.5
	else:
		speed = walk
		anim.speed_scale = 1

func _input(event):
	if Input.is_mouse_button_pressed(1) and canFire:
		$Timer.start(0.3)
		canFire = false
		firing = true
		var projectile = mageBall.instance()
		projectile.position = get_global_position()
		projectile.rotation_degrees = $DirectionHolder.rotation_degrees
		get_tree().get_root().add_child(projectile)

func playerAnim():
	if velocity.y < 0:
		anim.play("WalkU")
		direction = 3
		$DirectionHolder.rotation_degrees = 270
	if velocity.y > 0:
		anim.play("WalkD")
		direction = 1
		$DirectionHolder.rotation_degrees = 90
	if velocity.x < 0 and velocity.y == 0:
		anim.play("WalkL")
		direction = 2
		$DirectionHolder.rotation_degrees = 180
	if velocity.x > 0 and velocity.y == 0 and !firing:
		anim.play("WalkR")
		direction = 0
		$DirectionHolder.rotation_degrees = 0
	if velocity.x == 0 and velocity.y == 0:
		match direction:
			0:
				anim.play("IdleR")
			1:
				anim.play("IdleD")
			2:
				anim.play("IdleL")
			3:
				anim.play("IdleU")
	if firing:
		match direction:
			0:
				anim.play("AttackR")
			1:
				anim.play("AttackD")
			2:
				anim.play("AttackL")
			3:
				anim.play("AttackU")

func _physics_process(delta):
	playerAnim()
	getInput()
	velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	canFire = true
	firing = false
