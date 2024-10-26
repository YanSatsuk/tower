extends Node2D

@onready var enemy_scene = preload("res://scenes/enemies/emeny_1.tscn")  # Замените на путь к вашей сцене врага
var spawn_timer: Timer

func _ready():
	# Создаем таймер для спавна врагов
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 0.5  # Интервал между появлениями врагов
	spawn_timer.connect("timeout", _on_SpawnTimer_timeout)
	add_child(spawn_timer)
	spawn_timer.start()  # Запускаем таймер

func _on_SpawnTimer_timeout():
	# Создаем нового врага
	var enemy = enemy_scene.instantiate()
	
	# Устанавливаем случайное положение для врага
	if randi() % 2 == 0:
		enemy.position.x = 0  # Левый край
	else:
		enemy.position.x = get_viewport().size.x  # Правый край
	
	enemy.position.y = randf_range(0, get_viewport().size.y)  # Случайная высота
	add_child(enemy)  # Добавляем врага в сцену
