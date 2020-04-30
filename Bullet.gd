extends KinematicBody2D

var velocity = Vector2()
export (int) var speed
var damage


func _ready():
    set_process(true)
    
func start_at(pos, dir, type, dmg, _lifetime):
    $Sprite.animation = type
    position = pos
    rotation = dir
    damage = dmg
    velocity = Vector2(speed, 0).rotated(dir)
    add_to_group("bullets")


func _physics_process(delta):
    var collision = move_and_collide(velocity * delta)

    

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
    
func hit():
    velocity = Vector2(0, 0)
    $Sprite.hide()
    $Explosion.show()
    $Explosion.play("smoke")
    
func _on_Lifetime_timeout():
    hit()


func _on_Explosion_animation_finished():
    queue_free()




func _on_Area2D_body_entered(body):
    if not body.is_in_group("bullets"):
        print("Bullet_Spawned")
        hit()
        print(body.get_name())
        $Timer.start()
        
        


#Bounc       
#velocity = velocity.bounce(collision.normal)
#if collision.collider.has_method("hit"):
#collision.collider.hit()


func _on_Timer_timeout():
    velocity = Vector2(0, 0)
    $Sprite.hide()
    $Explosion.show()
    $Explosion.play("smoke")
