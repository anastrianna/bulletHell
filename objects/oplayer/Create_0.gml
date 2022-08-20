/// @desc
event_inherited();

maxHP = 10;
currentHP = maxHP;
movSpeed = 2;
baseAtkDamage = 5;
atkDamage = baseAtkDamage;
baseAtkSpeed = 1;
atkSpeedBuff = 0;
baseProjectileSpeed = 5;
projectileSpeed = baseProjectileSpeed;
projectileLifeSpan = 1;
effectPower = 100;
slowPower = 50;
slowDuration = 1;
baseHitStun = 0.5;
hitStun = baseHitStun;
experience = 0;

activeUpgradeList = ds_list_create();

state = "default";

image_index = 0;
image_speed = 0;