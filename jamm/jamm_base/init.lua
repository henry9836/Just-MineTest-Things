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

local function formspec_ALTAR()
	local formspec =
	'size[8,7.5]'..
	'list[context;input;3.5,2.5;1,1]'..
	'list[context;out_bucket;0,0;1,1]'..
	'button[6,2.5;2,1;start;Infuse]'..
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

-- INIT TOOLS

minetest.register_tool("jamm_base:ruby_pick", {
	description = "Ruby Pickaxe",
	inventory_image = "ruby_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("jamm_base:ruby_axe", {
	description = "Ruby Axe",
	inventory_image = "ruby_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

minetest.register_tool("jamm_base:ruby_shovel", {
	description = "Ruby Shovel",
	inventory_image = "ruby_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("jamm_base:ruby_sword", {
	description = "Ruby Sword",
	inventory_image = "ruby_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
})

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

minetest.register_craftitem("jamm_base:sugar", {
    description = "Sugar",
    inventory_image = "sugar_item.png",
    minetest.register_alias("Sugar", "jamm_base:sugar"),
    itemname = minetest.registered_aliases[itemname] or itemname,

    on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "It's got a sweat taste")
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
		groups = {can_altar=1},

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "It's a shiny")
			return itemstack
		end

})

minetest.register_craftitem("jamm_base:pure_ruby", {
    description = "Pure Infused Ruby",
    inventory_image = "ruby_pure.png",
    minetest.register_alias("Pure Infused Ruby", "jamm_base:pure_ruby"),
    itemname = minetest.registered_aliases[itemname] or itemname,

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You can feel an energy radiate off of it")
			return itemstack
		end

})

minetest.register_craftitem("jamm_base:dark_ruby", {
    description = "Dark Infused Ruby",
    inventory_image = "ruby_dark.png",
    minetest.register_alias("Dark Infused Ruby", "jamm_base:dark_ruby"),
    itemname = minetest.registered_aliases[itemname] or itemname,

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You can feel like something is watching you")
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

minetest.register_craftitem("jamm_base:pure_ring", {
    description = "Pure Infused Ring",
    inventory_image = "ring_pure.png",
    minetest.register_alias("Pure Infused Ring", "jamm_base:pure_ring"),
    itemname = minetest.registered_aliases[itemname] or itemname,

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "It's the perfect mold for pure magic")
		  return itemstack
    end
})

minetest.register_craftitem("jamm_base:dark_ring", {
    description = "Dark Infused Ring",
    inventory_image = "ring_dark.png",
    minetest.register_alias("Dark Infused Ring", "jamm_base:dark_ring"),
    itemname = minetest.registered_aliases[itemname] or itemname,

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You feel like someone is behind your shoulder, you turn around but don't see anyone")
		  return itemstack
    end
})

minetest.register_craftitem("jamm_base:exotic_matter", {
    description = "Exotic Matter",
    inventory_image = "exotic_matter.png",
    minetest.register_alias("Exotic Matter", "jamm_base:exotic_matter"),
    itemname = minetest.registered_aliases[itemname] or itemname,

		on_use = function(itemstack, placer, pointed_thing)
				minetest.chat_send_player(placer:get_player_name(), "You squish the matter in your fingers it feels slimy, you wipe your hand against your leg")
		  return itemstack
    end
})

minetest.register_craftitem("jamm_base:feather", {
    description = "Raven Feather",
    inventory_image = "feather.png",
    minetest.register_alias("Raven Feather", "jamm_base:feather"),
    itemname = minetest.registered_aliases[itemname] or itemname,
})

--INIT NODES

minetest.register_node("jamm_base:rubyore", {
    description = "Ruby Ore",
    tiles = {"ruby_ore.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1},
    drop = "jamm_base:ruby"
})

minetest.register_node("jamm_base:exotic_ore", {
    description = "Exotic Ore",
    tiles = {"exotic_ore.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1},
    drop = "jamm_base:exotic_matter"
})


minetest.register_node("jamm_base:jamm_grass", {
	description = "JAMM Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"grass.png"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "grass.png",
	wield_image = "grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},
	drop = "jamm_base:feather"
})

minetest.register_node("jamm_base:jamm_dry_grass", {
	description = "JAMM Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"dry_grass.png"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "dry_grass.png",
	wield_image = "dry_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},
	drop = "jamm_base:feather"
})


minetest.register_node("jamm_base:ruby_block", {
    tiles = {"ruby_block.png"},
		groups = {cracky=3, stone=1},
		minetest.register_alias("Ruby Block", "jamm_base:ruby_block"),
    itemname = minetest.registered_aliases[itemname] or itemname,
})

minetest.register_node("jamm_base:sugar_block", {
    tiles = {"sugar.png"},
		groups = {cracky=3, stone=1, oddly_breakable_by_hand=1},
		minetest.register_alias("Sugar Block", "jamm_base:sugar_block"),
    itemname = minetest.registered_aliases[itemname] or itemname,
})

minetest.register_node("jamm_base:more_sugar_block", {
    tiles = {"more_sugar.png"},
		groups = {cracky=3, stone=1, can_altar=1, oddly_breakable_by_hand=1},
		minetest.register_alias("More Sugar Block", "jamm_base:more_sugar_block"),
    itemname = minetest.registered_aliases[itemname] or itemname,
})

minetest.register_node("jamm_base:infused_sugar", {
    tiles = {"infused_sugar.png"},
		groups = {cracky=3, stone=1, oddly_breakable_by_hand=1},
		minetest.register_alias("Infused Sugar", "jamm_base:infused_sugar"),
    itemname = minetest.registered_aliases[itemname] or itemname,
})


--INIT GASES

minetest.register_node("jamm_base:steam", {
	tiles = {"steam.png"},
})

minetest.register_node("jamm_base:dark_gas", {
    tiles = {"evil_gas.png"},
		damage_per_second = 1 * 2,
})

-- NODES Advanced

minetest.register_node("jamm_base:exactionum_coactore", {
		description = "Exactionum Coactore",
		drawtype = "mesh",
		mesh = "exactionum_coactore.obj",
		tiles = {
        "exactionum_coactore.png"
    },
		minetest.register_alias("Exactionum Coactore", "jamm_base:exactionum_coactore"),
    itemname = minetest.registered_aliases[itemname] or itemname,
		groups = {oddly_breakable_by_hand=3},
		paramtype2 = 'facedir',
})

minetest.register_node("jamm_base:columnae_pure", {
		description = "Pure Columnae",
		drawtype = "mesh",
		mesh = "pillar.obj",
		tiles = {
        "pure_pillar.png"
    },
		minetest.register_alias("Pure Columnae", "jamm_base:columnae_pure"),
    itemname = minetest.registered_aliases[itemname] or itemname,
		groups = {oddly_breakable_by_hand=3},
		paramtype2 = 'facedir',
})

minetest.register_node("jamm_base:columnae_dark", {
		description = "Dark Columnae",
		drawtype = "mesh",
		mesh = "pillar.obj",
		tiles = {
        "dark_pillar.png"
    },
		minetest.register_alias("Dark Columnae", "jamm_base:columnae_dark"),
    itemname = minetest.registered_aliases[itemname] or itemname,
		groups = {oddly_breakable_by_hand=3},
		paramtype2 = 'facedir',
})

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
			 local ventspawn = {x = pos.x, y = pos.y+1, z = pos.z}

			 if (return_product.name == "jamm_base:bucket_dessence") then
			 	inv:set_stack('input', 1 ,"jamm_base:bucket_essence")
				--local obj = minetest.add_node(ventspawn, "jamm_base:steam")
 			 if obj then
 				    obj:setacceleration({x=0, y=1, z=0})
 			 end
			 elseif (return_product.name == "jamm_base:bucket_essence") then
				 inv:set_stack('input', 1 ,"jamm_base:essence_shard")
				 inv:set_stack('out_bucket', 1 ,"bucket:bucket_empty")
				 minetest.set_node(ventspawn, {name="jamm_base:dark_gas"})
				 if obj then
					    obj:setacceleration({x=0, y=1, z=0})
				 end
			 else
				 inv:set_stack('input', 1 ,return_product.returns)
			 end
			 boilpro = 100 -- reset ui pos
    end,
})

minetest.register_node("jamm_base:altare_pure", {
    description = "Pure Altare",
    drawtype = "mesh",
		mesh = "altar.obj",
		tiles = {
        "pure_altar.png"
    },
		minetest.register_alias("Pure Altare", "jamm_base:altare_pure"),
    itemname = minetest.registered_aliases[itemname] or itemname,
		groups = {oddly_breakable_by_hand=3},
		paramtype2 = 'facedir',
		on_construct = function(pos)
       local meta = minetest.get_meta(pos)
			 formspecb = formspec_ALTAR()
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
          if minetest.get_item_group(input, 'can_altar') == 1 then
	             timer:start(0)
					end
				end
      end,
    on_timer = function(pos)
			-- CHECK STRUCTURE
			local pos1 = {x = pos.x - 3, y = pos.y, z = pos.z + 3}
			local pos2 = {x = pos.x + 3, y = pos.y, z = pos.z + 3}
			local pos3 = {x = pos.x - 3, y = pos.y, z = pos.z - 3}
			local pos4 = {x = pos.x + 3, y = pos.y, z = pos.z - 3}
			local pos5 = {x = pos.x - 2, y = pos.y, z = pos.z + 2}
			local pos6 = {x = pos.x + 2, y = pos.y, z = pos.z + 2}
			local pos7 = {x = pos.x - 2, y = pos.y, z = pos.z - 2}
			local pos8 = {x = pos.x + 2, y = pos.y, z = pos.z - 2}

			local water1 = minetest.get_node(pos1)
			local water2 = minetest.get_node(pos2)
			local water3 = minetest.get_node(pos3)
			local water4 = minetest.get_node(pos4)
			local pill1 = minetest.get_node(pos5)
			local pill2 = minetest.get_node(pos6)
			local pill3 = minetest.get_node(pos7)
			local pill4 = minetest.get_node(pos8)

			if (pill1.name == "jamm_base:columnae_pure" and pill2.name == "jamm_base:columnae_pure" and pill3.name == "jamm_base:columnae_pure" and pill4.name == "jamm_base:columnae_pure") then
	      local meta = minetest.get_meta(pos)
	      local inv = meta:get_inventory()
	      local instack = inv:get_stack('input', 1)
				local return_product = minetest.registered_items[instack:get_name()]
				local ventspawn = {x = pos.x, y = pos.y+2, z = pos.z}
				if (return_product.name == "jamm_base:ruby") then
					 inv:set_stack('input', 1 ,"jamm_base:pure_ruby")
				elseif (return_product.name == "jamm_base:more_sugar_block") then
					 inv:set_stack('input', 1 ,"jamm_base:infused_sugar")
				else
					inv:set_stack('input', 1 , return_product.returns)
				end
		 	else
				--DEBUG
				--[[
			 	minetest.chat_send_all("BAD SETUP!")
				minetest.chat_send_all(dump(water1.name))
				minetest.chat_send_all(dump(water2.name))
				minetest.chat_send_all(dump(water3.name))
				minetest.chat_send_all(dump(water4.name))
				minetest.chat_send_all(dump(pill1.name))
				minetest.chat_send_all(dump(pill2.name))
				minetest.chat_send_all(dump(pill3.name))
				minetest.chat_send_all(dump(pill4.name))
				minetest.chat_send_all("BAD SETUP!")]]
			end
    end,
})

minetest.register_node("jamm_base:altare_dark", {
    description = "Dark Altare",
    drawtype = "mesh",
		mesh = "altar.obj",
		tiles = {
        "dark_altar.png"
    },
		minetest.register_alias("Dark Altare", "jamm_base:altare_dark"),
    itemname = minetest.registered_aliases[itemname] or itemname,
		groups = {oddly_breakable_by_hand=3},
		paramtype2 = 'facedir',
		on_construct = function(pos)
       local meta = minetest.get_meta(pos)
			 formspecb = formspec_ALTAR()
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
          if minetest.get_item_group(input, 'can_altar') == 1 then
	             timer:start(0)
					end
				end
      end,
    on_timer = function(pos)
			-- CHECK STRUCTURE
			local pos1 = {x = pos.x - 3, y = pos.y-1, z = pos.z + 3}
			local pos2 = {x = pos.x + 3, y = pos.y-1, z = pos.z + 3}
			local pos3 = {x = pos.x - 3, y = pos.y-1, z = pos.z - 3}
			local pos4 = {x = pos.x + 3, y = pos.y-1, z = pos.z - 3}
			local pos5 = {x = pos.x - 2, y = pos.y, z = pos.z + 2}
			local pos6 = {x = pos.x + 2, y = pos.y, z = pos.z + 2}
			local pos7 = {x = pos.x - 2, y = pos.y, z = pos.z - 2}
			local pos8 = {x = pos.x + 2, y = pos.y, z = pos.z - 2}

			local water1 = minetest.get_node(pos1)
			local water2 = minetest.get_node(pos2)
			local water3 = minetest.get_node(pos3)
			local water4 = minetest.get_node(pos4)
			local pill1 = minetest.get_node(pos5)
			local pill2 = minetest.get_node(pos6)
			local pill3 = minetest.get_node(pos7)
			local pill4 = minetest.get_node(pos8)
			if (pill1.name == "jamm_base:columnae_dark" and pill2.name == "jamm_base:columnae_dark" and pill3.name == "jamm_base:columnae_dark" and pill4.name == "jamm_base:columnae_dark") then
	      local meta = minetest.get_meta(pos)
	      local inv = meta:get_inventory()
	      local instack = inv:get_stack('input', 1)
				local return_product = minetest.registered_items[instack:get_name()]
				local ventspawn = {x = pos.x, y = pos.y+2, z = pos.z}
				if (return_product.name == "jamm_base:ruby") then
					 inv:set_stack('input', 1 ,"jamm_base:dark_ruby")
				else
					inv:set_stack('input', 1 ,return_product.returns)
				end
				minetest.set_node(ventspawn, {name="jamm_base:dark_gas"})
				if obj then
						obj:setacceleration({x=0, y=1, z=0})
				end
		 	else
				--DEBUG
			 	--[[minetest.chat_send_all("BAD SETUP!")
				minetest.chat_send_all(dump(water1.name))
				minetest.chat_send_all(dump(water2.name))
				minetest.chat_send_all(dump(water3.name))
				minetest.chat_send_all(dump(water4.name))
				minetest.chat_send_all(dump(pill1.name))
				minetest.chat_send_all(dump(pill2.name))
				minetest.chat_send_all(dump(pill3.name))
				minetest.chat_send_all(dump(pill4.name))
				minetest.chat_send_all("BAD SETUP!")]]
			end
    end,
})

-- INIT ABMS

minetest.register_abm({
	nodenames = {"jamm_base:steam"},
	interval = 1,
	chance = 1,
	action = function(pos)
    local pos1 = {x = pos.x, y = pos.y+1, z = pos.z}
		local pos2 = {x = pos.x+1, y = pos.y, z = pos.z}
		local pos3 = {x = pos.x, y = pos.y, z = pos.z+1}
		local pos4 = {x = pos.x-1, y = pos.y, z = pos.z}
		local pos5 = {x = pos.x, y = pos.y, z = pos.z-1}
    local neigh_node = minetest.get_node(pos1)
		local neigh_node2 = minetest.get_node(pos2)
		local neigh_node3 = minetest.get_node(pos3)
		local neigh_node4 = minetest.get_node(pos4)
		local neigh_node5 = minetest.get_node(pos5)
    if neigh_node.name == "air" then
			minetest.set_node(pos1, {name="jamm_base:steam"})
			minetest.set_node(pos, {name="air"})
		else
				 math.randomseed(os.time())
				 local r = math.random(1,4)
				 if r == 1 then
					if (neigh_node2.name == "air") then
						minetest.set_node(pos2, {name="jamm_base:steam"})
		 				minetest.set_node(pos, {name="air"})
					end
				 elseif r == 2 then
					 if (neigh_node3.name == "air") then
						minetest.set_node(pos3, {name="jamm_base:steam"})
	 	 				minetest.set_node(pos, {name="air"})
					end
				 elseif r == 3 then
					 if (neigh_node4.name == "air") then
						minetest.set_node(pos4, {name="jamm_base:steam"})
	 	 				minetest.set_node(pos, {name="air"})
					end
				 elseif r == 4 then
					 if (neigh_node5.name == "air") then
						minetest.set_node(pos5, {name="jamm_base:steam"})
	 	 				minetest.set_node(pos, {name="air"})
					end
			end
    end
	end,
})

minetest.register_abm({
	nodenames = {"jamm_base:dark_gas"},
	interval = 1,
	chance = 1,
	action = function(pos)
    local pos1 = {x = pos.x, y = pos.y+1, z = pos.z}
		local pos2 = {x = pos.x+1, y = pos.y, z = pos.z}
		local pos3 = {x = pos.x, y = pos.y, z = pos.z+1}
		local pos4 = {x = pos.x-1, y = pos.y, z = pos.z}
		local pos5 = {x = pos.x, y = pos.y, z = pos.z-1}
    local neigh_node = minetest.get_node(pos1)
		local neigh_node2 = minetest.get_node(pos2)
		local neigh_node3 = minetest.get_node(pos3)
		local neigh_node4 = minetest.get_node(pos4)
		local neigh_node5 = minetest.get_node(pos5)
    if neigh_node.name == "air" then
			minetest.set_node(pos1, {name="jamm_base:dark_gas"})
			minetest.set_node(pos, {name="air"})
		else
			if neigh_node.name ~= "jamm_base:exactionum_coactore" then
				 math.randomseed(os.time())
				 local r = math.random(1,4)
				 if r == 1 then
					if (neigh_node2.name == "air") then
						minetest.set_node(pos2, {name="jamm_base:dark_gas"})
		 				minetest.set_node(pos, {name="air"})
					end
				 elseif r == 2 then
					 if (neigh_node3.name == "air") then
						minetest.set_node(pos3, {name="jamm_base:dark_gas"})
	 	 				minetest.set_node(pos, {name="air"})
					end
				 elseif r == 3 then
					 if (neigh_node4.name == "air") then
						minetest.set_node(pos4, {name="jamm_base:dark_gas"})
	 	 				minetest.set_node(pos, {name="air"})
					end
				 elseif r == 4 then
					 if (neigh_node5.name == "air") then
						minetest.set_node(pos5, {name="jamm_base:dark_gas"})
	 	 				minetest.set_node(pos, {name="air"})
					end
				 end
			end
    end
	end,
})

minetest.register_abm({
	nodenames = {"jamm_base:exactionum_coactore"},
	interval = 1,
	chance = 1,
	action = function(pos)
    local pos1 = {x = pos.x, y = pos.y-1, z = pos.z}
		local pos2 = {x = pos.x, y = pos.y+1, z = pos.z}
    local neigh_node = minetest.get_node(pos1)
    if neigh_node.name == "jamm_base:dark_gas" then
      	minetest.set_node(pos1, {name="air"})
				minetest.set_node(pos2, {name="jamm_base:darkessence_source"})
    end
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
		liquid_viscosity = 3,
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
			liquid_viscosity = 3,
			post_effect_color = {a=80, r=0, g=221, b=0},
			groups = {water = 3, liquid = 3, puts_out_fire = 1,
				not_in_creative_inventory = 1, cools_lava = 1}
			--sounds = default.node_sound_water_defaults(),
		})

		minetest.register_node("jamm_base:darkessence_source", {
			description = "darkessence_source",
			drawtype = "liquid",
			tiles = {
				{
					name = "darkessence_source.png",
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
					name = "darkessence_source.png",
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
			liquid_alternative_flowing = "jamm_base:darkessence_flow",
			liquid_alternative_source = "jamm_base:darkessence_source",
			liquid_viscosity = 5,
			damage_per_second = 3 * 2,
			post_effect_color = {a=80, r=191, g=0, b=255},
			groups = {water = 3, liquid = 3, igniter = 1, cools_lava = 1}
			--sounds = default.node_sound_water_defaults(),
		})

		minetest.register_node("jamm_base:darkessence_flow", {
				drawtype = "flowingliquid",
				tiles = {"darkessence_flow.png"},
				special_tiles = {
					{
						name = "darkessence_flow.png",
						backface_culling = false,
						animation = {
							type = "vertical_frames",
							aspect_w = 16,
							aspect_h = 16,
							length = 0.8,
						},
					},
					{
						name = "darkessence_flow.png",
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
				liquid_alternative_flowing = "jamm_base:darkessence_flow",
				liquid_alternative_source = "jamm_base:darkessence_source",
				liquid_viscosity = 5,
				damage_per_second = 3 * 2,
				post_effect_color = {a=80, r=191, g=0, b=255},
				groups = {water = 3, liquid = 3, igniter = 1,
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

bucket.register_liquid(
		"jamm_base:darkessence_source",
		"jamm_base:darkessence_flow",
		"jamm_base:bucket_darkessence",
		"bucket_darkessence.png",
		"Dark Essence",
		{water_bucket = 1}
)

-- INIT ORE

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "jamm_base:jamm_grass",
  wherein        = "default:grass_1",
  clust_scarcity = 5*5*5,
  clust_num_ores = 4,
  clust_size     = 3,
  height_min     = -100,
  height_max     = 500,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "jamm_base:jamm_dry_grass",
  wherein        = "default:dry_grass_1",
  clust_scarcity = 5*5*5,
  clust_num_ores = 4,
  clust_size     = 3,
  height_min     = -100,
  height_max     = 500,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "jamm_base:rubyore",
  wherein        = "default:stone",
  clust_scarcity = 15*15*15,
  clust_num_ores = 4,
  clust_size     = 3,
  height_min     = -31000,
  height_max     = -250,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "jamm_base:exotic_ore",
  wherein        = "default:stone",
  clust_scarcity = 15*15*15,
  clust_num_ores = 4,
  clust_size     = 3,
  height_min     = -31000,
  height_max     = -4500,
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
    output = "jamm_base:pure_ring 1",
    recipe = {
        {"", "default:gold_ingot", ""},
        {"default:gold_ingot", "jamm_base:pure_ruby", "default:gold_ingot"},
        {"", "default:gold_ingot", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:dark_ring 1",
    recipe = {
        {"", "default:gold_ingot", ""},
        {"default:gold_ingot", "jamm_base:dark_ruby", "default:gold_ingot"},
        {"", "default:gold_ingot", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring_of_aqua 1",
    recipe = {
        {"", "bucket:bucket_water", ""},
        {"bucket:bucket_water", "jamm_base:pure_ring", "bucket:bucket_water"},
        {"", "bucket:bucket_water", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring_of_festina 1",
    recipe = {
        {"jamm_base:infused_sugar", "default:mese", "jamm_base:infused_sugar"},
        {"default:mese", "jamm_base:pure_ring", "default:mese"},
        {"jamm_base:infused_sugar", "default:mese", "jamm_base:infused_sugar"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:sugar 9",
    recipe = {
        {"default:papyrus", "default:papyrus", "default:papyrus"},
        {"default:papyrus", "default:papyrus", "default:papyrus"},
        {"default:papyrus", "default:papyrus", "default:papyrus"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:sugar_block 1",
    recipe = {
        {"jamm_base:sugar", "jamm_base:sugar", "jamm_base:sugar"},
        {"jamm_base:sugar", "jamm_base:sugar", "jamm_base:sugar"},
        {"jamm_base:sugar", "jamm_base:sugar", "jamm_base:sugar"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:more_sugar_block 1",
    recipe = {
        {"jamm_base:sugar_block", "jamm_base:sugar_block", "jamm_base:sugar_block"},
        {"jamm_base:sugar_block", "jamm_base:sugar_block", "jamm_base:sugar_block"},
        {"jamm_base:sugar_block", "jamm_base:sugar_block", "jamm_base:sugar_block"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:fervefacio 1",
    recipe = {
        {"default:steelblock", "default:steelblock", "default:steelblock"},
        {"default:steelblock", "bucket:bucket_lava", "default:steelblock"},
        {"default:steelblock", "default:steelblock", "default:steelblock"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring_of_fuga 1",
    recipe = {
        {"jamm_base:feather", "jamm_base:feather", "jamm_base:feather"},
        {"jamm_base:feather", "jamm_base:pure_ring", "jamm_base:feather"},
        {"jamm_base:feather", "jamm_base:feather", "jamm_base:feather"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ring_of_vita 1",
    recipe = {
        {"default:aspen_sapling", "default:apple", "default:acacia_sapling"},
        {"jamm_base:feather", "jamm_base:pure_ring", "flowers:rose"},
        {"default:pine_sapling", "flowers:waterlily", "default:junglesapling"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:columnae_pure 1",
    recipe = {
        {"jamm_base:essence_shard", "default:mossycobble", "jamm_base:essence_shard"},
        {"default:mossycobble", "jamm_base:exotic_matter", "default:mossycobble"},
        {"jamm_base:essence_shard", "default:mossycobble", "jamm_base:essence_shard"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:altare_pure 1",
    recipe = {
        {"default:mossycobble", "jamm_base:essence_shard", "default:mossycobble"},
        {"default:mossycobble", "jamm_base:exotic_matter", "default:mossycobble"},
        {"jamm_base:exotic_matter", "jamm_base:exotic_matter", "jamm_base:exotic_matter"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ruby_sword 1",
    recipe = {
        {"", "jamm_base:ruby", ""},
        {"", "jamm_base:ruby", ""},
        {"", "default:stick", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ruby_axe 1",
    recipe = {
        {"jamm_base:ruby", "jamm_base:ruby", ""},
        {"jamm_base:ruby", "default:stick", ""},
        {"", "default:stick", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ruby_shovel 1",
    recipe = {
        {"", "jamm_base:ruby", ""},
        {"", "default:stick", ""},
        {"", "default:stick", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ruby_pick 1",
    recipe = {
        {"jamm_base:ruby", "jamm_base:ruby", "jamm_base:ruby"},
        {"", "default:stick", ""},
        {"", "default:stick", ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ruby_block 1",
    recipe = {
        {"jamm_base:ruby", "jamm_base:ruby", "jamm_base:ruby"},
        {"jamm_base:ruby", "jamm_base:ruby", "jamm_base:ruby"},
        {"jamm_base:ruby", "jamm_base:ruby", "jamm_base:ruby"}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "jamm_base:ruby 9",
    recipe = {
        {"jamm_base:ruby_block", "", ""},
        {"", "", ""},
        {"", "", ""}
    }
})
