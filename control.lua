require "util"

script.on_event({defines.events.on_built_entity,defines.events.on_robot_built_entity},
  function(e)
    local this = e.created_entity
    local s = e.created_entity.surface
    if this.name == "blood-belt" or this.name == "blood-belt-fast" or this.name == "blood-belt-express" then
      local pos = this.position
      --game.print(pos)
      local nn = {
        s.find_entity("blood-belt",{pos.x,pos.y+1}), -- north
        s.find_entity("blood-belt",{pos.x+1,pos.y}), -- east
        s.find_entity("blood-belt",{pos.x,pos.y-1}), -- south
        s.find_entity("blood-belt",{pos.x-1,pos.y}), -- west
        s.find_entity("blood-belt-fast",{pos.x,pos.y+1}), -- north
        s.find_entity("blood-belt-fast",{pos.x+1,pos.y}), -- east
        s.find_entity("blood-belt-fast",{pos.x,pos.y-1}), -- south
        s.find_entity("blood-belt-fast",{pos.x-1,pos.y}), -- west
        s.find_entity("blood-belt-express",{pos.x,pos.y+1}), -- north
        s.find_entity("blood-belt-express",{pos.x+1,pos.y}), -- east
        s.find_entity("blood-belt-express",{pos.x,pos.y-1}), -- south
        s.find_entity("blood-belt-express",{pos.x-1,pos.y}) -- west
      }
      --game.print(nn)
      --for p in pairs(nn) do game.print(p) end
      
      --for i,b in pairs(nn) do game.print("found " .. i .. " and " .. b.name) end
      local has_neighbor = false
      for i,nbelt in pairs(nn) do
        has_neighbor = true
        this.connect_neighbour({
          wire = defines.wire_type.red,
          target_entity = nbelt
        })
        local cb = nbelt.get_control_behavior()
        cb.enable_disable = false
        cb.read_contents = true
        cb.read_contents_mode = defines.control_behavior.transport_belt.content_read_mode.hold
      end
      if has_neighbor then
        local cb = this.get_control_behavior()
        cb.enable_disable = false
        cb.read_contents = true
        cb.read_contents_mode = defines.control_behavior.transport_belt.content_read_mode.hold
      end
    end
  end
)