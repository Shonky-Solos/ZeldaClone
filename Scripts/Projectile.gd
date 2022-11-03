extends KinematicBody2D


export (int) var speed = 0
export (int) var damage = 0
export (float) var duration = 0
export (bool) var playerMade = false
var velocity = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = velocity.rotated(rotation)*speed
	$Timer.start(duration)


func _process(delta):
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	#print(str("Body Entered: ", body.get_name()))
	if playerMade:
		if body.name == "Player":
			pass #LEAVE - Player can't hurt self.
		else:
			#Deal Damage to enemy
			queue_free()
	#Runs for enemy projectiles
	if not playerMade:
		if body.name == "Player":
			#Deal damage to player
			queue_free()
		else:
			pass #LEAVE - Enemies can't hurt selves.


func _on_Timer_timeout():
	queue_free()
