pfUI:RegisterModule("custom", function ()

  table.insert(pfUI.gui.dropdowns["uf_texts"], "attackspeed:" .. T["Attack Speed"])
  table.insert(pfUI.gui.dropdowns["uf_texts"], "attackdmg:" .. T["Min/Max Damage"])

  local oldFunc = pfUI.uf.GetStatusValue
  function pfUI.uf.GetStatusValue(self, unit, pos)
    -- setup some basic variables used
    if not pos or not unit then return end
    local config = unit.config["txt"..pos]
    local unitstr = unit.label .. unit.id
    local frame = unit[pos .. "Text"]

    -- as a fallback, draw the name
    if pos == "center" and not config then
      config = "unit"
    end
    
    -- attack speed/dmg
    if config == "attackspeed" then
      local mainSpeed, offSpeed = UnitAttackSpeed("target")
      return unit:GetColor("unit") .. format("Spd: %.2f", mainSpeed) 
    elseif config == "attackdmg" then
      local lowDmg, hiDmg, offlowDmg = UnitDamage("target")
      return unit:GetColor("unit") .. format("Dmg: %.0f - %.0f", lowDmg, hiDmg)
	end
 
    -- run the original function
    return oldFunc(self, unit, pos)
  end
  
end)
