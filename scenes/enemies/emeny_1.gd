extends StaticBody2D

var speed = 75  # Скорость движения врага
var amplitude = 2  # Амплитуда синусоиды
var frequency = 5.0  # Частота синусоиды
var target_position = Vector2.ZERO  # Целевая позиция
var time_passed = 0.0  # Время для синусоидального движения

func _ready():
	add_to_group("enemies")
	# Устанавливаем начальную позицию врага
	if position.x < get_viewport().size.x / 2:
		# Если враг на левой стороне экрана
		position.x = 0
	else:
		# Если враг на правой стороне экрана
		position.x = get_viewport().size.x

	# Устанавливаем целевую позицию в центр экрана
	target_position = Vector2(get_viewport().size.x / 2 - 20, get_viewport().size.y / 2 - 25)

func _process(delta):
	# Обновляем время
	time_passed += delta

	# Вычисляем синусоидальное смещение
	var sine_offset = sin(time_passed * frequency) * amplitude

	# Вычисляем новое положение врага
	var direction = (target_position - position).normalized()
	position += direction * speed * delta  # Двигаем врага к цели

	# Применяем синусоидальное смещение к вертикальной позиции
	position.y += sine_offset

	# Проверяем, достиг ли враг центра экрана
	if position.distance_to(target_position) < 10:
		pass
		#queue_free()  # Удаляем врага, если он достиг центра
