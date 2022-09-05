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
basePickupRadius = 50;
pickupRadius = basePickupRadius;

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
	["Strength", "Increase base damage of attack", false, 0, 5, 0],
	["Attack Speed", "Increase speed of attack", false, 0, 3, 0],
	["Projectile Speed", "Increase speed of projectiles", false, 0, 2, 0],
	["Health", "Increase maximum health", false, "Health Regen", 2, 0],
	["Health Regen", "Gain health regeneration", true, 0, 1, 0],
	["Infection", "Apply infection with attacks", false, 0, 1, 0],
	["Crit", "Crit chance", false,  0, 1, 0],
	["Projectile Count", "Increase number of projectiles produced", false, 0, 3, 0],
	["Weaken", "Chance to debuff enemies to recieve more damage", false, 0, 1, 0],
	["Movement Speed", "Increase player movement speed", false, 0, 3, 0],
	["Effect Power", "Increase effect power", false, 0, 2, 0],
	["Range", "Increase range of attacks and projectiles", false, 0, 2, 0],
	["Pickup Radius", "Increase range for grabbing collectables", false, 0, 2, 0]
);

enum upgradesColumns {
	name,
	description,
	requirement,
	unlock, //0 for no unlock
	maxTier,
	currentTier,
	count
}

global.availableUpgrades = ds_list_create();
global.activeUpgrades = ds_list_create();

for(var i = 0; i < ds_grid_height(global.playerUpgrades); i++) {
	if(!global.playerUpgrades[# upgradesColumns.requirement, i]) { ds_list_add(global.availableUpgrades, global.playerUpgrades[# upgradesColumns.name, i]); }
}

global.maxChoices = 4;