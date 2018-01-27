require("item-groups")

local inheritance = {
   ["blood-belt"] = "transport-belt",
   ["blood-belt-fast"] = "fast-transport-belt",
   ["blood-belt-express"] = "express-transport-belt"
}

local icon_prefix = "__bloodbelt__/graphics/icons/"
local sprite_prefix = "__bloodbelt__/graphics/"

-- We should probably just rename the items or the images, but I
-- didn't want to move a bunch of files or force a migration yet...
local icon_name = {
   ["blood-belt"] = "blood-belt",
   ["blood-belt-fast"] = "fast-blood-belt",
   ["blood-belt-express"] = "express-blood-belt"
}

for new_name, old_name in pairs(inheritance) do
   local new_item = table.deepcopy(data.raw.item[old_name])
   new_item.name = new_name
   new_item.subgroup = "bb-belt"
   new_item.icon = icon_prefix .. icon_name[new_name] .. ".png"
   new_item.icon_size = 32
   new_item.place_result = new_name

   local new_recipe = table.deepcopy(data.raw.recipe[old_name])
   new_recipe.name = new_name
   new_recipe.enabled = false
   new_recipe.ingredients =
      {{old_name, new_recipe.result_count or 1}, {"red-wire", 1}}
   new_recipe.result = new_name

   local new_entity = table.deepcopy(data.raw["transport-belt"][old_name])
   new_entity.name = new_name
   new_entity.minable.result = new_name

   -- cf. belt_frame_connector_template in
   -- data/core/lualib/circuit_connector_generated_definitions.lua

   -- I've set these to transparent images again, this time with
   -- sizing matching the new hr 0.16 style.  Changing dimensions is
   -- very tricky, as a lot of the rest of the code makes assumptions
   -- about the numbers of variations and connection points, etc.
   new_entity.connector_frame_sprites.frame_main.sheet.filename =
      sprite_prefix .. "blood-frame.png"
   new_entity.connector_frame_sprites.frame_shadow.sheet.filename =
      sprite_prefix .. "blood-frame-shadow.png"
   new_entity.connector_frame_sprites.frame_main_scanner.filename =
      sprite_prefix .. "blood-scanner.png"
   new_entity.connector_frame_sprites.frame_main_scanner_nw_ne.filename =
      sprite_prefix .. "blood-scanner-nw-ne.png"
   new_entity.connector_frame_sprites.frame_main_scanner_sw_se.filename =
      sprite_prefix .. "blood-scanner-sw-se.png"

   data:extend{new_item, new_recipe, new_entity}
   table.insert(data.raw.technology["circuit-network"].effects,
                { type = "unlock-recipe",
                  recipe = new_name })
end
