
generaleffecttime = 2

-- SERVER SIDE

minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		local inhand = player:get_wielded_item() -- Get Held Item
		local stringofhand = inhand:to_string()
		-- RINGS
		--minetest.chat_send_all("JAMM DEBUG: "..stringofhand) --DEBUG
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
    player:set_physics_override(4,nil,nil)
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

minetest.register_node("jamm_base:rubyore", {
    description = "Ruby Ore",
    tiles = {"ruby_ore.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1},
    drop = "jamm_base:ruby"
})

-- INIT ORE

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "jamm_base:rubyore",
  wherein        = "default:stone",
  clust_scarcity = 8*8*8,
  clust_num_ores = 8,
  clust_size     = 3,
  height_min     = -31000,
  height_max     = 64,
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
