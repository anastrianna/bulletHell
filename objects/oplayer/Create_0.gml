/// @desc
event_inherited();

maxHP = 5;
currentHP = maxHP;
movSpeed = 2;
baseAtkDamage = 5;
atkDamage = baseAtkDamage;
baseAtkSpeed = 1;
atkSpeedBuff = 0;
baseRange = 200;
range = baseRange;
critChance = 0;
baseProjectileSpeed = 5;
projectileSpeed = baseProjectileSpeed;
baseProjectiles = 1;
bonusProjectiles = 0;
effectPower = 100;
slowPower = 25;
slowDuration = 1;
baseHitStun = 0.5;
hitStun = baseHitStun;
experience = 0;
levelCost = 5;

state = "default";

availableMutations = ds_list_create();
activeMutations = ds_list_create();

image_index = 0;
image_speed = 0;

//Ideally incorporate into upgrades grid
infectionDamage = 3;
infectionDuration = 3;

//Initialize upgrades
global.playerUpgrades = createGrid(
	["Strength", "Increase base damage of attack", 5, 0],
	["Attack Speed", "Increase speed of attack", 3, 0],
	["Projectile Speed", "Increase speed of projectiles", 2, 0],
	["Health", "Increase maximum health", 2, 0],
	["Health Regen", "Gain health regeneration", 1, 0],
	["Infection", "Apply infection with attacks", 1, 0],
	["Crit", "Crit chance", 1, 0],
	["Projectile Count", "Increase number of projectiles produced from", 3, 0],
	["Weaken", "Chance to debuff enemies to recieve more damage", 1, 0],
	["Movement Speed", "Increase player movement speed", 3, 0],
	["Effect Power", "Increase effect power", 2, 0],
	["Range", "Increase range of attacks and projectiles", 2, 0]
);

enum upgradesColumns {
	name,
	description,
	maxTier,
	currentTier,
	count
}

global.availableUpgrades = ds_list_create();

for(var i = 0; i < ds_grid_height(global.playerUpgrades); i++) {
	ds_list_add(global.availableUpgrades, global.playerUpgrades[# upgradesColumns.name, i]);
}

global.maxChoices = 4;