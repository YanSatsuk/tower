extends RigidBody2D

var speed = 800  # Скорость пули

func _ready():
	# Устанавливаем скорость пули
	pass

func _process(delta):
	# Проверяем, выходит ли пуля за пределы экрана
	if not get_viewport().get_visible_rect().has_point(position):
		queue_free()  # Удаляем пулю

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):  # Проверяем, является ли объект врагом
		body.queue_free()  # Удаляем врага
		queue_free()  # Удаляем пулю
