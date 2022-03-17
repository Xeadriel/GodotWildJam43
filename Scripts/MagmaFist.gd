extends Projectile
class_name MagmaFist

onready var areaShape = $Area2D/CollisionShape2D
onready var effectArea = $EffectArea
onready var effectAreaShape = $EffectArea/EffectShape
onready var conePreview = $ConePreview

var activated = false
var effectTimer = 0

func bodyCollided(body : Node) -> void:
	if (body is Enemy):
		areaShape.disabled = true
		activated = true
		effectArea.global_position = body.global_position-direction
		rotation = effectArea.global_position.angle_to_point(effectArea.global_position + direction)
		self_modulate.a = 0
		conePreview.visible = true
		

func _process(delta: float) -> void:
	if activated:
		if effectTimer >= 0.01:
			var bodies = effectArea.get_overlapping_bodies()
			for body in bodies:
				if (body is Enemy):
					print("hi")
					body.magmaFist(direction)
			effectAreaShape.disabled = true
			conePreview.visible = false
			timer = 4.5 # so that it frees in 0.5 seconds
		effectTimer+=delta
