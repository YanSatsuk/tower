extends RigidBody2D

var speed = 800  # Скорость пули

func _ready():
	# Устанавливаем скорость пули
	pass

func _process(delta):
	# Проверяем, выходит ли пуля за пределы экрана
	if not get_viewport().get_visible_rect().has_point(position):
		queue_free()  # Удаляем пулю
