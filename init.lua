rng = PseudoRandom(414)

function generate_random_name()
    local names = {
	"tomson",
	"lolcat",
	"luckymucky",
	"ls",
	"nano",
	"vim",
	"emacs",
	"libera",
	"jarjar",
	"mumi",
	"moomoo",
	"meowmeow",
	"quack",
	"loldog",
	"lulu",
	"jiyo",
	"moon",
	"octo"
    }
    return names[rng:next(1, #names)] .. " " .. names[rng:next(1, #names)]
end

minetest.register_node("harharcobble:harharcobble", {
    description = "HarHar cobblestone",
    tiles = {"default_cobble.png"},
    drop = "default:cobble",
    groups = {cracky = 3, stone = 2},
    sounds = default.node_sound_stone_defaults(),
    stack_max = 6,
    is_ground_content = false,
    after_place_node = function(pos, placer)
	if placer and placer:get_pos() then
            local meta = minetest.get_meta(pos)
	    local player_name = placer:get_player_name()
	    local node_name = generate_random_name()
	    meta:set_string("placer", player_name)
	    meta:set_string("name", node_name)
	    meta:mark_as_private("placer")
	    minetest.chat_send_player(
	        player_name,
	        "You have placed a har har stone named "..node_name
	    )
	end
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
	local placer_name = oldmetadata["placer"]
	local node_name = oldmetadata["name"]
	local placer = minetest.get_player_by_name(placer_name)
	local digger_name = digger:get_player_name()
        if placer and placer:get_pos() then
	    minetest.chat_send_player(
	    	placer_name,
		digger_name .. " has dug your harhar cobble named " .. node_name
	    )
	end
    end
})
