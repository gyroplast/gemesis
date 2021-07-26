CRAFT_DESC_ORANGE_GEM = "Orange you glad this is craftable now?"
CRAFT_DESC_GREEN_GEM = "Less hope, more magic!"
_G = GLOBAL

local function IsDST()
  return GLOBAL.TheSim:GetGameID() == "DST"
end

local function _GetRecipe(prefab)
  if IsDST() then
    return GLOBAL.AllRecipes[prefab]
  else
    --return GLOBAL.GetRecipe(prefab)
    return GLOBAL.GetAllRecipes(true)[prefab]
  end
end

local purplegem_recipe = _GetRecipe("purplegem")
_G.STRINGS.RECIPE_DESC["ORANGEGEM"] = CRAFT_DESC_ORANGE_GEM
_G.STRINGS.RECIPE_DESC["GREENGEM"] = CRAFT_DESC_GREEN_GEM

local function DS_create_gem_recipes()
  local orangegem_recipe = Recipe(
      "orangegem",
      {Ingredient("redgem",1), Ingredient("yellowgem", 1)},
      purplegem_recipe.tab,
      purplegem_recipe.level
      )
    orangegem_recipe.sortkey = purplegem_recipe.sortkey + 0.1

  local greengem_recipe = Recipe(
      "greengem",
      {Ingredient("bluegem",1), Ingredient("yellowgem", 1)},
      purplegem_recipe.tab,
      purplegem_recipe.level
      )
    greengem_recipe.sortkey = orangegem_recipe.sortkey + 0.1

end

local function DST_create_gem_recipes()
  local orangegem_recipe = AddRecipe(
      "orangegem",
      {_G.Ingredient("redgem",1), _G.Ingredient("yellowgem", 1)},
      purplegem_recipe.tab,
      purplegem_recipe.level,
      { placer = purplegem_recipe.placer, no_deconstruction = false },
      purplegem_recipe.min_spacing,
      purplegem_recipe.nounlock,
      purplegem_recipe.numtogive,
      purplegem_recipe.builder_tag,
      purplegem_recipe.atlas,
      nil,
      purplegem_recipe.testfn,
      "orangegem")
  orangegem_recipe.sortkey = purplegem_recipe.sortkey + 0.1
  
  local greengem_recipe = AddRecipe(
      "greengem",
      {_G.Ingredient("bluegem",1), _G.Ingredient("yellowgem", 1)},
      purplegem_recipe.tab,
      purplegem_recipe.level,
      { placer = purplegem_recipe.placer, no_deconstruction = false },
      purplegem_recipe.min_spacing,
      purplegem_recipe.nounlock,
      purplegem_recipe.numtogive,
      purplegem_recipe.builder_tag,
      purplegem_recipe.atlas,
      nil,
      purplegem_recipe.testfn,
      "greengem")
  greengem_recipe.sortkey = orangegem_recipe.sortkey + 0.1
end


local function decorated_spell(f)
  return function (staff, dt)
    -- only spawn extra ingredients when applied to purple, orange, or green gem
    if string.sub(dt.prefab, -3) == "gem" then
      local recipe = _GetRecipe(dt.prefab)
      for i, v in ipairs(recipe.ingredients) do
        for n = 1, v.amount do
          local loot = _G.SpawnPrefab(v.type)
          local x, y, z = dt.Transform:GetWorldPosition()
          local angle = math.random() * 2 * math.pi
          loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))
          x = x + math.cos(angle) * math.random(3)
          z = z + math.sin(angle) * math.random(3)
          loot.Transform:SetPosition(x, y, z)
          loot:PushEvent("on_loot_dropped", {dropper = dt})
        end
      end
      if not IsDST() then
        local caster = staff.components.inventoryitem.owner
        if caster.components.sanity then
            caster.components.sanity:DoDelta(-TUNING.SANITY_MEDLARGE)
        end

        staff.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
        staff.components.finiteuses:Use(1)

        if dt.components.inventory then
          dt.components.inventory:DropEverything()
        end

        if dt.components.container then
          dt.components.container:DropEverything()
        end

        if dt.components.stackable then
          dt = dt.components.stackable:Get()
        end

        dt:Remove()

        if dt.components.resurrector and not dt.components.resurrector.used then
          local player = GetPlayer()
          if player then
            player.components.health:RecalculatePenalty()
          end
        end
      end
    end
    return f(staff, dt)
  end
end

local override_spell = function(prefab)
  if prefab.components.spellcaster and prefab.components.spellcaster.spell then
    prefab.components.spellcaster:SetSpellFn(decorated_spell(prefab.components.spellcaster.spell))
  end
end

if IsDST() then
  DST_create_gem_recipes()
else
  DS_create_gem_recipes()
end

AddPrefabPostInit("greenstaff", override_spell)
