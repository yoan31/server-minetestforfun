local function nextrange(x, max)
	x = x + 1
	if x > max then
		x = 0
	end
	return x
end

local ROTATE_FACE = 1
local ROTATE_AXIS = 2
local USES = 200
local USES_perfect = 10000

-- Handles rotation
local function screwdriver_handler(itemstack, user, pointed_thing, mode)
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under

	if minetest.is_protected(pos, user:get_player_name()) then
		minetest.record_protection_violation(pos, user:get_player_name())
		return
	end

	local node = minetest.get_node(pos)
	local ndef = minetest.registered_nodes[node.name]
	if not ndef or not ndef.paramtype2 == "facedir" or
			(ndef.drawtype == "nodebox" and
			not ndef.node_box.type == "fixed") or
			node.param2 == nil then
		return
	end

	if ndef.can_dig and not ndef.can_dig(pos, user) then
		return
	end

	-- Set param2
	local n = node.param2
	local axisdir = math.floor(n / 4)
	local rotation = n - axisdir * 4
	if mode == ROTATE_FACE then
		n = axisdir * 4 + nextrange(rotation, 3)
	elseif mode == ROTATE_AXIS then
		n = nextrange(axisdir, 5) * 4
	end

	node.param2 = n
	minetest.swap_node(pos, node)

	if not minetest.setting_getbool("creative_mode") and minetest.register_tool("screwdriver:screwdriver_perfect") then
		itemstack:add_wear(65535 / (USES_perfect - 1))
	elseif not minetest.setting_getbool("creative_mode")
		itemstack:add_wear(65535 / (USES - 1))
	end

	return itemstack
end

-- Screwdriver (en steel à 200 utilisation)
minetest.register_tool("screwdriver:screwdriver", {
	description = "Screwdriver (left-click rotates face, right-click rotates axis)",
	inventory_image = "screwdriver.png",
	on_use = function(itemstack, user, pointed_thing)
		screwdriver_handler(itemstack, user, pointed_thing, ROTATE_FACE)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		screwdriver_handler(itemstack, user, pointed_thing, ROTATE_AXIS)
		return itemstack
	end,
}
-- Perfect Screwdriver (en mithril à 10 000 utilisations)
minetest.register_tool("screwdriver:screwdriver_perfect", {
	description = "Perfect Screwdriver (left-click rotates face, right-click rotates axis)",
	inventory_image = "screwdriver_perfect.png",
	on_use = function(itemstack, user, pointed_thing)
		screwdriver_handler(itemstack, user, pointed_thing, ROTATE_FACE)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		screwdriver_handler(itemstack, user, pointed_thing, ROTATE_AXIS)
		return itemstack
	end,
})


minetest.register_craft({
	output = "screwdriver:screwdriver",
	recipe = {
		{"default:steel_ingot"},
		{"group:stick"}
	}
minetest.register_craft({
	output = "screwdriver:screwdriver_perfect",
	recipe = {
		{"moreoress:mithril_ingot"},
		{"group:stick"}
	}
})

minetest.register_alias("screwdriver:screwdriver1", "screwdriver:screwdriver")
minetest.register_alias("screwdriver:screwdriver2", "screwdriver:screwdriver")
minetest.register_alias("screwdriver:screwdriver3", "screwdriver:screwdriver")
minetest.register_alias("screwdriver:screwdriver4", "screwdriver:screwdriver")
