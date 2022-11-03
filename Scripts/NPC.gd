extends Area2D

var canInteract = false
export(Array, String) var dialogs : Array = []

func _ready():
	$Label.visible = false
	get_node("DialogueBox").visible = false

func _on_NPC_body_entered(body):
	if body.name == "Player":
		$Label.visible = true
		canInteract = true


func _on_NPC_body_exited(body):
	if body.name == "Player":
		canInteract = false
		$Label.visible = false

func _input(event):
	if Input.is_key_pressed(KEY_E) and canInteract:
		$Label.visible = false
		get_node("DialogueBox").visible = true
		canInteract = false
