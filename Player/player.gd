extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var camera: Camera3D = $Camera3D
@onready var ui: UI = $"/root/Main/UI"
@onready var interact_ray: RayCast3D = $Camera3D/InteractRay


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mousePosition: Vector2

func _process(_delta):
	var interactable: Interactable
	if interact_ray.is_colliding() && interact_ray.get_collider() is Interactable:
		interactable = interact_ray.get_collider() as Interactable
		ui.interact_prompt.set_interaction_type(interactable.interaction_type)
	else:
		ui.interact_prompt.clear_interaction()

func _physics_process(delta):
	if GameState.game_state == Enums.GameStates.ACTIVE:
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta
	
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()

func _input(event):
	if GameState.game_state == Enums.GameStates.ACTIVE:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * PlayerSettings.sens))
			camera.rotate_x(deg_to_rad(-event.relative.y * PlayerSettings.sens))
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

		if Input.is_action_just_pressed("interact") && interact_ray.is_colliding() &&\
			interact_ray.get_collider() is Interactable:
			(interact_ray.get_collider() as Interactable).interaction_triggered.emit()
