extends Node2D

@onready var tower = %BulletTowerSprite2D
@onready var bullet_scene = preload("res://scenes/tower/bullets/bullet.tscn")
var shoot_delay = 0.05  # Задержка между выстрелами
var time_since_last_shot = 0.0
var bullet_count = 0;
@export var bullet_limit = 100;

func _ready():
	add_to_group("tower")
	# Получаем размеры окна
	var screen_size = get_viewport().get_size()
	
	# Устанавливаем позицию спрайта в центр экрана
	position = screen_size / 2
	
	# Если спрайт имеет размеры, учитываем его центрирование
	position -= tower.texture.get_size() / 2

func _process(delta):
	# Получаем позицию курсора мыши в мировых координатах
	var mouse_position = get_global_mouse_position()

	# Вычисляем угол между башней и курсором
	var direction = (mouse_position - global_position).normalized()
	var angle = direction.angle()

	# Поворачиваем башню
	rotation = angle + deg_to_rad(90)
	
	time_since_last_shot += delta  # Увеличиваем время с последнего выстрела

	if Input.is_action_pressed("fire"):
		if time_since_last_shot >= shoot_delay:  # Проверяем, прошло ли достаточно времени
			shoot()
			time_since_last_shot = 0.0  # Сбрасываем таймер

func _input(event):
	pass

func shoot():
	if bullet_count == bullet_limit:
		return
		
	var bullet = bullet_scene.instantiate()

	# Получаем позицию курсора мыши в мировых координатах
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()

	bullet.position = position  # Устанавливаем позицию пули
	bullet.rotation = direction.angle()  # Устанавливаем угол пули
	bullet.linear_velocity = direction * bullet.speed  # Устанавливаем скорость пули
	
	get_parent().add_child(bullet)
	bullet_count += 1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print('enemy attacked!')
		get_tree().paused = true
