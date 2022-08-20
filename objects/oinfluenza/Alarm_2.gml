/// @desc Basic Attack

var proj = instance_create_layer(x, y, "Instances", oSpore);
proj.damage = atkDamage;
proj.movSpeed = projectileSpeed;
proj.direction = point_direction(x, y, mouse_x, mouse_y);
proj.lifeSpan = projectileLifeSpan;