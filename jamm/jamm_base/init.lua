
-- GLOBALS

local generaleffecttime = 2
local boilpro = 100
local formspecb

-- SERVER SIDE

minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		local inhand = player:get_wielded_item() -- Get Held Item
		local stringofhand = inhand:to_string()
		--minetest.chat_send_all("JAMM DEBUG: "..stringofhand) --DEBUG

		-- RINGS
		if stringofhand == "jamm_base:ring_of_aqua" then
			player:set_breath(11) --change players breath to 11 so they can breath
			playereffects.apply_effect_type("neptuneEffect", generaleffecttime, player)
		elseif stringofhand == "jamm_base:ring_of_vita" then
			playereffects.apply_effect_type("vitaEffect", generaleffecttime, player)
		elseif stringofhand == "jamm_base:ring_of_fuga" then
			playereffects.apply_effect_type("fugaEffect", generaleffecttime, player)
		elseif stringofhand == "jamm_base:ring_of_festina" then
			playereffects.apply_effect_type("festinaEffect", generaleffecttime, player)
		end
	end
end)

-- FORMSPECS

local function formspec_BOILER(boilpro)
	local formspec =
	'size[8,7.5]'..
	'list[context;input;3.5,2.5;1,1]'..
	'list[context;out_bucket;0,0;1,1]'..
	'button[6,2.5;2,1;start;Boil]'..
	 "image[3.5,1.5;1,1;gui_boiler_bg_bubbles.png^[lowpart:"..
	 (100 - boilpro)..":gui_boiler_fg_bubbles.png^[transformR0]"..
	'list[current_player;main;0,3.5;8,4]'
	return formspec
end

-- INIT EFFECTS

playereffects.register_effect_type("neptuneEffect", "Aqua", "r_neptune_on.png", {"speed"},
	function(player)
    player:set_breath(11)
	end,

	function(effect, player)
    --nothing
	end
)

playereffects.register_effect_type("vitaEffect", "Vita", "r_vita_on.png", {"health"},
	function(player)
		player:set_hp(player:get_hp()+1)
	end
)

playereffects.register_effect_type("fugaEffect", "Fuga", "r_fuga_on.png", {"gravity"},
function(player)
	local playername = player:get_player_name()
	local privs = minetest.get_player_privs(playername)
	privs.fly = true
	minetest.set_player_privs(playername, privs)
end,
function(effect, player)
	local privs = minetest.get_player_privs(effect.playername)
	privs.fly = nil
	minetest.set_player_privs(effect.playername, privs)
end,
false,
true
)

playereffects.register_effect_type("festinaEffect", "Festina", "r_festina_on.png", {"speed"},
	function(player)
    player:set_physics_override(6,nil,nil)
	end,

	function(effect, player)
    player:set_physics_override(1,nil,nil)
	end
)


--INIT RINGS

minetest.register_craftitem("jamm_base:ring_of_aqua", {
    description = "Ring Of Aqua",
    inventory_image = "r_neptune_on.png",
    minetest.register_alias("Ring Of Neptune", "jamm_base:ring_of_aqua"),
    itemname = minetest.registered_aliases[itemname] or itemname,

    on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You put your ear close to it and you can swear that you hear the sound of waves crashing")
		  return itemstack
    end
})

minetest.register_craftitem("jamm_base:ring_of_vita", {
    description = "Ring Of Vita",
    inventory_image = "r_vita_on.png",
    minetest.register_alias("Ring Of Vita", "jamm_base:ring_of_vita"),
    itemname = minetest.registered_aliases[itemname] or itemname,

    on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You rub the ring and it gives a pleasant feeling")
		  return itemstack
    end
})

minetest.register_craftitem("jamm_base:ring_of_fuga", {
    description = "Ring Of Fuga",
    inventory_image = "r_fuga_on.png",
    minetest.register_alias("Ring Of Fuga", "jamm_base:ring_of_fuga"),
    itemname = minetest.registered_aliases[itemname] or itemname,

    on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You put the ring on the the tip of your finger and it glides slowly and gently into place")
		  return itemstack
    end
})

minetest.register_craftitem("jamm_base:ring_of_festina", {
    description = "Ring Of Festina",
    inventory_image = "r_festina_on.png",
    minetest.register_alias("Ring Of Festina", "jamm_base:ring_of_festina"),
    itemname = minetest.registered_aliases[itemname] or itemname,

    on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You hold the ring with two fingers, it seems to vibrate with energy")
		  return itemstack
    end
})

--INIT ITEMS

minetest.register_craftitem("jamm_base:ruby", {
    description = "Ruby",
    inventory_image = "ruby.png",
    minetest.register_alias("Ruby", "jamm_base:ruby"),
    itemname = minetest.registered_aliases[itemname] or itemname,

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "It's a shiny")
			return itemstack
		end

})

minetest.register_craftitem("jamm_base:essence_shard", {
    description = "Essence Shard",
    inventory_image = "essence_shard.png",
    minetest.register_alias("Essence Shard", "jamm_base:essence_shard"),
    itemname = minetest.registered_aliases[itemname] or itemname,

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You feel it pulsate with energy")
			return itemstack
		end

})

minetest.register_craftitem("jamm_base:ring", {
    description = "Ring",
    inventory_image = "ring.png",
    minetest.register_alias("Ring", "jamm_base:ring"),
    itemname = minetest.registered_aliases[itemname] or itemname,

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "Looks nice on your finger...wait what finger?")
		  return itemstack
    end
})

--INIT GASES

minetest.register_entity("jamm_base:steam", {
    hp_max = 1,
    physical = true,
    weight = 5,
    collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    visual = "sprite",
    visual_size = {x=1, y=1},
    mesh = "cube",
    textures = {"steam.png"}, -- number of required textures depends on visual
    colors = {}, -- number of required colors depends on visual
    spritediv = {x=1, y=1},
    initial_sprite_basepos = {x=0, y=0},
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
		on_step = function(pos)
			--local m_pos = {pos.x, y = pos.y, z = pos.z}
	 end
})

minetest.register_entity("jamm_base:evil_gas", {
    hp_max = 1,
    physical = true,
    weight = 5,
		damage = 1,
    collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    visual = "cube",
    visual_size = {x=1, y=1},
    mesh = "cube",
    textures = {"evil_gas.png" ,"evil_gas.png" ,"evil_gas.png" ,"evil_gas.png" ,"evil_gas.png" ,"evil_gas.png"}, -- number of required textures depends on visual
    colors = {}, -- number of required colors depends on visual
    spritediv = {x=1, y=1},
    initial_sprite_basepos = {x=0, y=0},
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
		on_step = function(pos)
			--local m_pos = {pos.x, y = pos.y, z = pos.z}
	 end
})

--INIT NODES

minetest.register_node("jamm_base:rubyore", {
    description = "Ruby Ore",
    tiles = {"ruby_ore.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1},
    drop = "jamm_base:ruby"
})

-- NODES Advanced

minetest.register_node("jamm_base:fervefacio", {
    description = "Fervefacio Machine",
    drawtype = "mesh",
		mesh = "boiler.obj",
		tiles = {
        "boiler.png"
    },
		minetest.register_alias("Fervefacio Machine", "jamm_base:fervefacio"),
    itemname = minetest.registered_aliases[itemname] or itemname,
		groups = {oddly_breakable_by_hand=3},
		paramtype2 = 'facedir',
		on_construct = function(pos)
       local meta = minetest.get_meta(pos)
			 formspecb = formspec_BOILER(boilpro)
			 meta:set_string("formspec", formspecb)
       local inv = meta:get_inventory()
       inv:set_size('input', 1)
    end,
    on_receive_fields = function(pos, formname, fields, sender)
       local meta = minetest.get_meta(pos)
       local inv = meta:get_inventory()
       local instack = inv:get_stack('input', 1)
       local input = instack:get_name()
       local timer = minetest.get_node_timer(pos)
       if fields ['start'] then
          if minetest.get_item_group(input, 'boilable') == 1 then
						 if (boilpro > 1) then
							 boilpro = boilpro - 25
							 meta:set_string("formspec", formspec_BOILER(boilpro))
						 else
	             timer:start(0)
							 meta:set_string("formspec", formspec_BOILER(100))
						end
          end
       end
    end,
    on_timer = function(pos)
       local meta = minetest.get_meta(pos)
       local inv = meta:get_inventory()
       local instack = inv:get_stack('input', 1)
			 local return_product = minetest.registered_items[instack:get_name()]
			 minetest.chat_send_all("JAMM DEBUG: "..dump(pos))
			 local ventspawn = {x = pos.x, y = pos.y+1, z = pos.z}

			 if (return_product.name == "jamm_base:bucket_dessence") then
			 	inv:set_stack('input', 1 ,"jamm_base:bucket_essence")
				local obj = minetest.add_entity(ventspawn, "jamm_base:steam")
 			 if obj then
 				    obj:setacceleration({x=0, y=1, z=0})
 			 end
			 elseif (return_product.name == "jamm_base:bucket_essence") then
				 inv:set_stack('input', 1 ,"jamm_base:essence_shard")
				 inv:set_stack('out_bucket', 1 ,"bucket:bucket_empty")
				 local obj = minetest.add_entity(ventspawn, "jamm_base:evil_gas")
				 if obj then
					    obj:setacceleration({x=0, y=1, z=0})
				 end
			 else
				 inv:set_stack('input', 1 ,return_product.returns)
			 end
			 boilpro = 100 -- reset ui pos
    end,
})


-- LIQUIDS

minetest.register_node("jamm_base:dessence_source", {
	description = "dessence_source",
	drawtype = "liquid",
	tiles = {
		{
			name = "dessence_source.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name = "dessence_source.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "jamm_base:dessence_flow",
	liquid_alternative_source = "jamm_base:dessence_source",
	liquid_viscosity = 1,
	post_effect_color = {a=75, r=33, g=134, b=100},
	groups = {water = 3, liquid = 3, puts_out_fire = 1, cools_lava = 1}
	--sounds = default.node_sound_water_defaults(),
})

minetest.register_node("jamm_base:dessence_flow", {
		drawtype = "flowingliquid",
		tiles = {"dessence_tex.png"},
		special_tiles = {
			{
				name = "dessence_flow.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 0.8,
				},
			},
			{
				name = "dessence_flow.png",
				backface_culling = true,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 0.8,
				},
			},
		},
		alpha = 160,
		paramtype = "light",
		paramtype2 = "flowingliquid",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = 1,
		liquidtype = "flowing",
		liquid_alternative_flowing = "jamm_base:dessence_flow",
		liquid_alternative_source = "jamm_base:dessence_source",
		liquid_viscosity = 1,
		post_effect_color = {a=75, r=33, g=134, b=100},
		groups = {water = 3, liquid = 3, puts_out_fire = 1,
			not_in_creative_inventory = 1, cools_lava = 1}
		--sounds = default.node_sound_water_defaults(),
	})

	minetest.register_node("jamm_base:essence_source", {
		description = "essence_source",
		drawtype = "liquid",
		tiles = {
			{
				name = "essence_source.png",
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
			},
		},
		special_tiles = {
			-- New-style water source material (mostly unused)
			{
				name = "essence_source.png",
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
				backface_culling = false,
			},
		},
		alpha = 160,
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = 1,
		liquidtype = "source",
		liquid_alternative_flowing = "jamm_base:essence_flow",
		liquid_alternative_source = "jamm_base:essence_source",
		liquid_viscosity = 1,
		post_effect_color = {a=80, r=0, g=221, b=0},
		groups = {water = 3, liquid = 3, puts_out_fire = 1, cools_lava = 1}
		--sounds = default.node_sound_water_defaults(),
	})

	minetest.register_node("jamm_base:essence_flow", {
			drawtype = "flowingliquid",
			tiles = {"essence_tex.png"},
			special_tiles = {
				{
					name = "essence_flow.png",
					backface_culling = false,
					animation = {
						type = "vertical_frames",
						aspect_w = 16,
						aspect_h = 16,
						length = 0.8,
					},
				},
				{
					name = "essence_flow.png",
					backface_culling = true,
					animation = {
						type = "vertical_frames",
						aspect_w = 16,
						aspect_h = 16,
						length = 0.8,
					},
				},
			},
			alpha = 160,
			paramtype = "light",
			paramtype2 = "flowingliquid",
			walkable = false,
			pointable = false,
			diggable = false,
			buildable_to = true,
			is_ground_content = false,
			drop = "",
			drowning = 1,
			liquidtype = "flowing",
			liquid_alternative_flowing = "jamm_base:essence_flow",
			liquid_alternative_source = "jamm_base:essence_source",
			liquid_viscosity = 1,
			post_effect_color = {a=80, r=0, g=221, b=0},
			groups = {water = 3, liquid = 3, puts_out_fire = 1,
				not_in_creative_inventory = 1, cools_lava = 1}
			--sounds = default.node_sound_water_defaults(),
		})

-- INIT buckets

bucket.register_liquid(
	"jamm_base:dessence_source",
	"jamm_base:dessence_flow",
	"jamm_base:bucket_dessence",
	"bucket_dessence.png",
	"Diluted Essence",
	{water_bucket = 1, boilable=1}
	)

bucket.register_liquid(
		"jamm_base:essence_source",
		"jamm_base:essence_flow",
		"jamm_base:bucket_essence",
		"bucket_essence.png",
		"Pure Essence",
		{water_bucket = 1, boilable=1}
)

-- INIT ORE

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "jamm_base:rubyore",
  wherein        = "default:stone",
  clust_scarcity = 14*14*14,
  clust_num_ores = 8,
  clust_size     = 3,
  height_min     = -31000,
  height_max     = 64,
})

minetest.register_ore({
  ore_type       = "blob",
  ore            = "jamm_base:dessence_source",
  wherein        = "default:water_source",
  clust_scarcity = 27*27*27,
  clust_num_ores = 80,
  clust_size     = 10,
  height_min     = -10,
  height_max     = 31000,
})

--INIT CRAFTING

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring 1",
    recipe = {
        {"", "default:gold_ingot", ""},
        {"default:gold_ingot", "jamm_base:ruby", "default:gold_ingot"},
        {"", "default:gold_ingot", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring_of_aqua 1",
    recipe = {
        {"", "bucket:bucket_water", ""},
        {"bucket:bucket_water", "jamm_base:ring", "bucket:bucket_water"},
        {"", "bucket:bucket_water", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring_of_vita 1",
    recipe = {
        {"", "default:apple", ""},
        {"default:apple", "jamm_base:ring", "default:apple"},
        {"", "default:apple", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring_of_fuga 1",
    recipe = {
        {"", "default:flint", ""},
        {"default:flint", "jamm_base:ring", "default:flint"},
        {"", "default:flint", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring_of_festina 1",
    recipe = {
        {"", "default:flint", ""},
        {"default:flint", "jamm_base:ring", "default:flint"},
        {"", "default:flint", ""}
    }
})
