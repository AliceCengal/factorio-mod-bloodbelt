
require("item-groups")

local bloodbelt_invisible_sprite = {
  filename    = "__bloodbelt__/graphics/bb-invis.png",
  frame_count = 1,
  line_length = 1,
  priority    = "low",
  width       = 34,
  height      = 34,
  x           = 0,
  y           = 0,
  shift       = {0, 0},
}

local bloodbelt_invisible_sheet = {
    draw_as_shadow = true,
    filename = "__bloodbelt__/graphics/bb-invis.png",
    frame_count = 1,
    height = 4,
    line_length = 1,
    priority = "low",
    scale = 0.5,
    shift = {0,0},
    variation_count = 7,
    width = 34,
}

function bloodbelt_basename(path)
    local lastpart
    for part in string.gmatch(path, '[^/]+') do
        lastpart = part
    end
    return lastpart
end

-- lookup table to make bloodbelt_modify_belt more D.R.Y.
local bloodbelt_config_lut = {}

bloodbelt_config_lut["transport-belt"] = {
        icon_prefix = "",
        name_suffix = "",
}
bloodbelt_config_lut["fast-transport-belt"] = {
        icon_prefix = "fast-",
        name_suffix = "-fast",
}
bloodbelt_config_lut["express-transport-belt"] = {
        icon_prefix = "express-",
        name_suffix = "-express",
}

function bloodbelt_modify_recipe(belt_type)
    local config         = bloodbelt_config_lut[belt_type]
    if belt_type == "express-transport-belt" then
		  bbrecipe = table.deepcopy(data.raw.recipe["fast-transport-belt"])
	  else
		  bbrecipe = table.deepcopy(data.raw.recipe[belt_type])
	  end

    bbrecipe.name        = "blood-belt" .. config.name_suffix
    bbrecipe.enabled     = false
    bbrecipe.ingredients = {{belt_type,2}, {"red-wire",1}}
    bbrecipe.result      = bbrecipe.name

    return bbrecipe
end

function bloodbelt_modify_item(belt_type)
    local bbitem    = table.deepcopy(data.raw.item[belt_type])
    local config    = bloodbelt_config_lut[belt_type]

    bbitem.name     = "blood-belt" .. config.name_suffix
    bbitem.subgroup = "bb-belt"

    bbitem.icon     = "__bloodbelt__/graphics/icons/" ..
        config.icon_prefix ..
        "blood-belt.png"

    bbitem.icon_size    = 32
    bbitem.place_result = bbitem.name

    return bbitem
end

function bloodbelt_modify_entity(belt_type)
    local bbentity = table.deepcopy(data.raw["transport-belt"][belt_type])
    local config   = bloodbelt_config_lut[belt_type]

    bbentity.name           = "blood-belt"  .. config.name_suffix
    bbentity.minable.result = bbentity.name

    local framesprites                    = table.deepcopy(bbentity.connector_frame_sprites)
    framesprites.frame_main.sheet         = bloodbelt_invisible_sheet
    framesprites.frame_shadow.sheet       = bloodbelt_invisible_sheet
    framesprites.frame_main_scanner       = bloodbelt_invisible_sprite
    framesprites.frame_main_scanner_nw_ne = bloodbelt_invisible_sprite
    framesprites.frame_main_scanner_sw_se = bloodbelt_invisible_sprite
    bbentity.connector_frame_sprites      = framesprites

    local modsprite = "__bloodbelt__/graphics/" ..
        config.icon_prefix ..
        "transport-belt/" ..
        bloodbelt_basename(bbentity.animations.filename):gsub('.png', '-mod.png')
    local modhrsprite = "__bloodbelt__/graphics/" ..
        config.icon_prefix ..
        "transport-belt/" ..
        bloodbelt_basename(bbentity.animations.filename):gsub('.png', '-mod.png')

    bbentity.animations.filename                 = modsprite
    -- bbentity.animations.hr_version.filename      = modhrsprite
    bbentity.belt_horizontal.filename            = modsprite
    -- bbentity.belt_horizontal.hr_version.filename = modhrsprite
    bbentity.belt_vertical.filename              = modsprite
    -- bbentity.belt_vertical.hr_version.filename   = modhrsprite

    local circuitsprites = table.deepcopy(bbentity.circuit_connector_sprites)
    for index,sprite in ipairs(circuitsprites) do
        sprite.frame_main         = bloodbelt_invisible_sprite
        sprite.frame_main_scanner = bloodbelt_invisible_sprite
        sprite.led_red            = bloodbelt_invisible_sprite
        sprite.led_green          = bloodbelt_invisible_sprite
        sprite.led_blue           = bloodbelt_invisible_sprite
        sprite.frame_shadow       = bloodbelt_invisible_sprite
    end
    bbentity.circuit_connector_sprites = circuitsprites
    bbentity.circuit_connector_sprites = nil

    local wirepoints = bbentity.circuit_wire_connection_points
    for index,point in ipairs(wirepoints) do
        point.wire.red     = {0.1, -0.1} -- this is the coordinate from the center of the square. positive is rightward and downward
        point.shadow.red   = point.wire.red
        point.wire.green   = {0.1, -0.2}
        point.shadow.green = point.wire.green
    end
    -- Remove excess wirepoints
    while #wirepoints > #circuitsprites do
        table.remove(wirepoints)
    end
    return bbentity
end

function bloodbelt_modify_belt(belt_type)
    local bbitem   = bloodbelt_modify_item(belt_type)
    local bbrecipe = bloodbelt_modify_recipe(belt_type)
    local bbentity = bloodbelt_modify_entity(belt_type)

    print("#### BB")
    -- print(serpent.block(bbitem))
    print(serpent.block(bbentity))
    -- print(serpent.block(bbrecipe))
    print("#### /BB")
    data:extend{bbitem,bbrecipe,bbentity}
end

-- Yellow blood belt
bloodbelt_modify_belt('transport-belt')
-- Red blood belt
bloodbelt_modify_belt('fast-transport-belt')
-- Blue blood belt
bloodbelt_modify_belt('express-transport-belt')

local techeffects = data.raw.technology["circuit-network"].effects
table.insert(techeffects, { type = "unlock-recipe", recipe = "blood-belt" } )
table.insert(techeffects, { type = "unlock-recipe", recipe = "blood-belt-fast" } )
table.insert(techeffects, { type = "unlock-recipe", recipe = "blood-belt-express" } )




