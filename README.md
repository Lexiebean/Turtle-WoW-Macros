# Turtle-WoW-Macros
A collection of useful macros and addon edits for Turtle WoW.

**Buff Macro** - Alt to self cast. Will not buff PVP flagged targets. - by Nakie
```lua
/script spell="Power Word: Fortitude"; onself=IsAltKeyDown(); if onself or not UnitExists("target") or UnitIsEnemy("player", "target") or not UnitIsPVP("target") then CastSpellByName(spell, onself) end
```

**Shows your target's Min & Max damage**  
```lua
/script L, H = UnitDamage("target") DEFAULT_CHAT_FRAME:AddMessage(format("%s Dmg: %.0f - %.0f", GetUnitName("target"), L, H))
```

**Shows your target's Attack Speed**  
```lua
/run mainSpeed, offSpeed = UnitAttackSpeed("target") DEFAULT_CHAT_FRAME:AddMessage(format("%s: attack speed = %.2f", GetUnitName("target"), mainSpeed))
```

**Shows your target's Armour and Resistances**   
```lua
/run u=UnitResistance y="target" a=u(y ,0) h=u(y ,1) f=u(y ,2) n=u(y ,3) fr=u(y ,4) s=u(y ,5) z=u(y ,6) DEFAULT_CHAT_FRAME:AddMessage(UnitName(y).." has "..a.." Armor, "..f.." Fire, "..n.." Nature, "..z.." Arcane, "..fr.." Frost and "..s.." Shadow res.")
```

**Spammable Wand Macro** - For this one you have to place the Shoot/Wand ability from your spell book on action slot "12". Which by default is where "=" is bound to.  
Holding shift while using the macro will "orverride" the macro and make the button work like normal. I had a problem where sometimes after being knocked down by an NPC I wasn't able to start wanding again by using the spamable button.  
```lua
/script if(IsShiftKeyDown()) then CastSpellByName('Shoot') elseif not IsAutoRepeatAction(12) then CastSpellByName('Shoot') end
```

**Rested Exp (Bubbles)**
```lua
/script p="player";x=UnitXP(p);m=UnitXPMax(p);r=GetXPExhaustion();if -1==(r or -1)then t="No rest."else t="Rest: "..(math.floor(20*r/m+0.5)).." bubbles ("if r+x<m then t=t..r else t=t.."level +"..(r+x-m)end t=t.."XP)"end;DEFAULT_CHAT_FRAME:AddMessage(t)
```

**Rested Exp (Percentage, up to 150%) - by Nakie**
```lua
/script DEFAULT_CHAT_FRAME:AddMessage(format("%d%% rested", 100 * GetXPExhaustion() / UnitXPMax("player")))
```

**One-Button Tent**
```lua
/run CastSpellByName("Survival") for r=1,GetNumTradeSkills() do if GetTradeSkillInfo(r) == "Traveler's Tent" then DoTradeSkill(r,1) break end end CloseTradeSkill()
```

---

**SUPER MACROS**

**YOU NEED THE [SUPERMACRO](https://github.com/isitLoVe/SuperMacro/) ADDON FOR THESE MACROS**

Delete Torch - Scans your inventory for any Dim Torches and deletes them. (Great for those early levels of Survival)  

![pfUI Changes](https://github.com/Lexiebean/Turtle-WoW-Macros/blob/main/DeleteTorch.png)

Macro:  
```lua
/run DeleteTorch()
```

Extended LUA:  
```lua
function DeleteTorch()
    local bag, slot;
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local link = GetContainerItemLink(bag, slot);
            if (link and IsTorch(link)) then
                PickupContainerItem(bag, slot);
                DeleteCursorItem();
            end
        end
    end
end

function IsTorch(link)
    local index;
    if (DeleteTorch_ExtractLinkID(link) == 6182) then
        return true;
    end
    return false;
end

function DeleteTorch_ExtractLinkID(link)
    _, _, id = string.find(link, "Hitem:(.+):%d+:%d+:%d+%\124");
    return tonumber(id);
end
```

---

**pfUI Changes**

![pfUI Changes](https://github.com/Lexiebean/Turtle-WoW-Macros/blob/main/pfUIChanges.png)

pfUI\modules\gui.lua around ``line 1024``  
```lua
        "attackspeed:" .. T["Attack Speed"],
        "attackdmg:" .. T["Min/Max Damage"],
```
![pfUI Changes](https://github.com/Lexiebean/Turtle-WoW-Macros/blob/main/pfUguiChange.png)

pfUI\api\unitframes.lua around ``line 2343``  
```lua
-- attack speed/dmg
  elseif config == "attackspeed" then
    local mainSpeed, offSpeed = UnitAttackSpeed("target")
    return unit:GetColor("unit") .. format("Spd: %.2f", mainSpeed) 
  elseif config == "attackdmg" then
    local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("target")
    return unit:GetColor("unit") .. format("Dmg: %.0f - %.0f", lowDmg, hiDmg)
```

![pfUI Changes](https://github.com/Lexiebean/Turtle-WoW-Macros/blob/main/pfUIunitframesChange.png)

Then when you edit your unti frames in game you should have some new data strings to choose from for your healthbar or powerbar texts. I display mine on my targets manabar/powerbar.

![pfUI Changes](pfUI-in-game-settings.png)
