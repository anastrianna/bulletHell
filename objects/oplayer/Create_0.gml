/// @desc
event_inherited();

maxHP = 10;
currentHP = maxHP;
movSpeed = 2;
baseAtkDamage = 5;
atkDamage = baseAtkDamage;
baseAtkSpeed = 1;
atkSpeedBuff = 0;
critChance = 0;
baseProjectileSpeed = 5;
projectileSpeed = baseProjectileSpeed;
projectileLifeSpan = 1;
bonusProjectiles = 0;
effectPower = 100;
slowPower = 25;
slowDuration = 1;
baseHitStun = 0.5;
hitStun = baseHitStun;
experience = 0;
levelCost = 10;

state = "default";

availableMutations = ds_list_create();
activeMutations = ds_list_create();

image_index = 0;
image_speed = 0;

//Ideally incorporate into upgrades grid
infectionDamage = 3;
infectionDuration = 2;