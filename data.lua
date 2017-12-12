
require("item-groups")

-- Yellow blood belt

local bbitem = table.deepcopy(data.raw.item["transport-belt"])
bbitem.name="blood-belt"
bbitem.subgroup="bb-belt"
bbitem.icon="__bloodbelt__/graphics/icons/blood-belt.png"
bbitem.icon_size = 32
bbitem.place_result = bbitem.name

local bbrecipe = table.deepcopy(data.raw.recipe["transport-belt"])
bbrecipe.name = "blood-belt"
bbrecipe.enabled = false
bbrecipe.ingredients = {{"transport-belt",2}, {"red-wire",1}}
bbrecipe.result = bbrecipe.name

local bbentity = table.deepcopy(data.raw["transport-belt"]["transport-belt"])
bbentity.name = "blood-belt"
bbentity.minable.result = bbentity.name

local spriteinvis = {
  filename = "__bloodbelt__/graphics/bb-invis.png",
  priority = "low",
  width = 34,
  height = 34,
  shift = {0, 0},
}

local framesprites = table.deepcopy(bbentity.connector_frame_sprites)
framesprites.frame_main_h = spriteinvis
framesprites.frame_main_ne = spriteinvis
framesprites.frame_main_nw = spriteinvis
framesprites.frame_main_sw = spriteinvis
framesprites.frame_main_se = spriteinvis
framesprites.frame_main_v = spriteinvis
framesprites.frame_main_x = spriteinvis
framesprites.frame_shadow_h = spriteinvis
framesprites.frame_shadow_ne = spriteinvis
framesprites.frame_shadow_nw = spriteinvis
framesprites.frame_shadow_sw = spriteinvis
framesprites.frame_shadow_se = spriteinvis
framesprites.frame_shadow_v = spriteinvis
framesprites.frame_shadow_x = spriteinvis
bbentity.connector_frame_sprites = framesprites

data:extend{bbitem,bbrecipe,bbentity}

-- Red blood belt

local bbitem = table.deepcopy(data.raw.item["fast-transport-belt"])
bbitem.name="blood-belt-fast"
bbitem.subgroup="bb-belt"
bbitem.icon="__bloodbelt__/graphics/icons/fast-blood-belt.png"
bbitem.icon_size = 32
bbitem.place_result = bbitem.name

local bbrecipe = table.deepcopy(data.raw.recipe["fast-transport-belt"])
bbrecipe.name = "blood-belt-fast"
bbrecipe.enabled = false
bbrecipe.ingredients = {{"fast-transport-belt",1}, {"red-wire",1}}
bbrecipe.result = bbrecipe.name

local bbentity = table.deepcopy(data.raw["transport-belt"]["fast-transport-belt"])
bbentity.name = "blood-belt-fast"
bbentity.minable.result = bbentity.name

local framesprites = table.deepcopy(bbentity.connector_frame_sprites)
framesprites.frame_main_h = spriteinvis
framesprites.frame_main_ne = spriteinvis
framesprites.frame_main_nw = spriteinvis
framesprites.frame_main_sw = spriteinvis
framesprites.frame_main_se = spriteinvis
framesprites.frame_main_v = spriteinvis
framesprites.frame_main_x = spriteinvis
framesprites.frame_shadow_h = spriteinvis
framesprites.frame_shadow_ne = spriteinvis
framesprites.frame_shadow_nw = spriteinvis
framesprites.frame_shadow_sw = spriteinvis
framesprites.frame_shadow_se = spriteinvis
framesprites.frame_shadow_v = spriteinvis
framesprites.frame_shadow_x = spriteinvis
bbentity.connector_frame_sprites = framesprites

data:extend{bbitem,bbrecipe,bbentity}

-- Blue blood belt

local bbitem = table.deepcopy(data.raw.item["express-transport-belt"])
bbitem.name="blood-belt-express"
bbitem.subgroup="bb-belt"
bbitem.icon="__bloodbelt__/graphics/icons/express-blood-belt.png"
bbitem.icon_size = 32
bbitem.place_result = bbitem.name

local bbrecipe = table.deepcopy(data.raw.recipe["fast-transport-belt"])
bbrecipe.name = "blood-belt-express"
bbrecipe.enabled = false
bbrecipe.ingredients = {{"express-transport-belt",1}, {"red-wire",1}}
bbrecipe.result = bbrecipe.name

local bbentity = table.deepcopy(data.raw["transport-belt"]["express-transport-belt"])
bbentity.name = "blood-belt-express"
bbentity.minable.result = bbentity.name

local framesprites = table.deepcopy(bbentity.connector_frame_sprites)
framesprites.frame_main_h = spriteinvis
framesprites.frame_main_ne = spriteinvis
framesprites.frame_main_nw = spriteinvis
framesprites.frame_main_sw = spriteinvis
framesprites.frame_main_se = spriteinvis
framesprites.frame_main_v = spriteinvis
framesprites.frame_main_x = spriteinvis
framesprites.frame_shadow_h = spriteinvis
framesprites.frame_shadow_ne = spriteinvis
framesprites.frame_shadow_nw = spriteinvis
framesprites.frame_shadow_sw = spriteinvis
framesprites.frame_shadow_se = spriteinvis
framesprites.frame_shadow_v = spriteinvis
framesprites.frame_shadow_x = spriteinvis
bbentity.connector_frame_sprites = framesprites

data:extend{bbitem,bbrecipe,bbentity}

local techeffects = data.raw.technology["circuit-network"].effects
table.insert(techeffects, { type = "unlock-recipe", recipe = "blood-belt" } )
table.insert(techeffects, { type = "unlock-recipe", recipe = "blood-belt-fast" } )
table.insert(techeffects, { type = "unlock-recipe", recipe = "blood-belt-express" } )




