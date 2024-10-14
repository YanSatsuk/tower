extends Node2D

@onready var sprite = %BulletTowerSprite2D
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
var shoot_delay = 0.05  # Задержка между выстрелами
var time_since_last_shot = 0.0

func _ready():
	# Получаем размеры окна
	var screen_size = get_viewport().get_size()
	
	# Устанавливаем позицию спрайта в центр экрана
	sprite.position = screen_size / 2
	
	# Если спрайт имеет размеры, учитываем его центрирование
	sprite.position -= sprite.texture.get_size() / 2

func _process(delta):
	# Получаем позицию курсора мыши в мировых координатах
	var mouse_position = get_global_mouse_position()

	# Вычисляем угол между башней и курсором
	var direction = (mouse_position - sprite.global_position).normalized()
	var angle = direction.angle()

	# Поворачиваем башню
	sprite.rotation = angle + deg_to_rad(90)
	
	time_since_last_shot += delta  # Увеличиваем время с последнего выстрела

	if Input.is_action_pressed("fire"):
		if time_since_last_shot >= shoot_delay:  # Проверяем, прошло ли достаточно времени
			shoot()
			time_since_last_shot = 0.0  # Сбрасываем таймер

func _input(event):
	pass

func shoot():
	var bullet = bullet_scene.instantiate()

	# Получаем позицию курсора мыши в мировых координатах
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - sprite.position).normalized()

	bullet.position = sprite.position  # Устанавливаем позицию пули
	bullet.rotation = direction.angle()  # Устанавливаем угол пули
	bullet.linear_velocity = direction * bullet.speed  # Устанавливаем скорость пули
	
	get_parent().add_child(bullet)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("enemies"):  # Проверяем, является ли объект врагом
		print('DEAD')
		get_tree().paused = true
