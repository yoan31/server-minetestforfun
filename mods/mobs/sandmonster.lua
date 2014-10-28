
-- Sand Monster

mobs:register_mob("mobs:sand_monster", {
	type = "monster",
	hp_min = 10,
	hp_max = 20,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_sand_monster.x",
	textures = {"mobs_sand_monster.png"},
	visual_size = {x=8,y=8},
	makes_footstep_sound = true,
	view_range = 16,
	walk_velocity = 3,
	run_velocity = 5,
	damage = 3,
	drops = {
		{name = "default:desert_sand",
		chance = 1,
		min = 3,
		max = 5,},
		{name = "maptools:copper_coin",
		chance = 2,
		min = 2,
		max = 4,},
	},
	light_resistant = true,
	armor = 90,
	drawtype = "front",
	water_damage = 3,
	lava_damage = 1,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 39,
		walk_start = 41,
		walk_end = 72,
		run_start = 74,
		run_end = 105,
		punch_start = 74,
		punch_end = 105,
	},
	jump = true,
	step = 1,
	blood_texture = "mobs_blood.png",
})
mobs:register_spawn("mobs:sand_monster", {"default:desert_sand", "default:sand"}, 20, -1, 4500, 1, 31000)
