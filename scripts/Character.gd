extends Node2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		
	if velocity.y != 0 or velocity.x != 0:
		$KinematicBody2D/AnimatedSprite.play("running")
		
		if velocity.x == -1:
			$KinematicBody2D/AnimatedSprite.flip_h = true
		else:
			$KinematicBody2D/AnimatedSprite.flip_h = false
	else:
		$KinematicBody2D/AnimatedSprite.play("idle")
		
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = $KinematicBody2D.move_and_slide(velocity)
