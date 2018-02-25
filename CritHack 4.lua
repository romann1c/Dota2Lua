local AutoCrit = {}

AutoCrit.CritMode = 0
AutoCrit.CritKey = Menu.AddKeyOption({"Utility", "Auto Crit"}, "Crit Key", Enum.ButtonCode.KEY_O)
AutoCrit.Font = Renderer.LoadFont("Tahoma", 24, Enum.FontWeight.EXTRABOLD)

AutoCrit.NPCs = {}

AutoCrit.HeroList = {
    "npc_dota_hero_phantom_assassin",
    "npc_dota_hero_skeleton_king",
    "npc_dota_hero_juggernaut",
    "npc_dota_hero_chaos_knight",
    "npc_dota_hero_brewmaster",
    "npc_dota_hero_pangolier",
    "npc_dota_hero_morphling",
    "npc_dota_hero_bounty_hunter"
}

AutoCrit.CritAnimationList = {
    "phantom_assassin_attack_crit_anim",
    "attack_crit_alt_anim",
    "attack_crit_anim",
    "Attack Critical_anim",
    "attack_event",
    "arcana_attack_crit_v1",
    "arcana_attack_crit_v2",
    "arcana_attack_crit_v3",
    "attack_jinada_alt_anim",
    "attack_jinada_anim"
}

AutoCrit.NormalAnimationList = {
    "Attack Alternate_anim",
    "Attack_anim",
    "arcana_attack1",
    "arcana_attack2",
    "arcana_attack3",
    "arcana_attack4",
    "arcana_attack5",
    "attack",
    "attack01",
    "attack01_fast",
    "attack01_faster",
    "attack01_fastest",
    "attack01_stab",
    "attack01_stab_fast",
    "attack01_stab_faster",
    "attack01_stab_fastest",
    "attack02",
    "attack02_fast",
    "attack02_faster",
    "attack02_fastest",
    "attack02_stab",
    "attack02_stab_fast",
    "attack02_stab_faster",
    "attack02_stab_fastest",
    "attack03",
    "attack03_fast",      
    "attack03_faster",
    "attack03_fastest",
    "attack03_stab",
    "attack03_stab_fast",
    "attack03_stab_faster",
    "attack03_stab_fastest",
    "attack1",
    "attack1_fast",
    "attack1_faster",
    "attack1_fastest",
    "attack1_stab",
    "attack1_stab_fast",
    "attack1_stab_faster",
    "attack1_stab_fastest",
    "attack2",
    "attack2_anim",
    "attack2_fast",
    "attack2_faster",
    "attack2_fastest",
    "attack2_stab",
    "attack2_stab_fast",
    "attack2_stab_faster",
    "attack2_stab_fastest",
    "attack3",
    "attack3_anim",
    "attack3_fast",      
    "attack3_faster",
    "attack3_fastest",
    "attack3_stab",
    "attack3_stab_fast",
    "attack3_stab_faster",
    "attack3_stab_fastest",
    "attack_01",
    "attack_01_fast",
    "attack_01_faster",
    "attack_01_fastest",
    "attack_01_stab",
    "attack_01_stab_fast",
    "attack_01_stab_faster",
    "attack_01_stab_fastest",
    "attack_02",
    "attack_02_fast",
    "attack_02_faster",
    "attack_02_fastest",
    "attack_02_stab",
    "attack_02_stab_fast",
    "attack_02_stab_faster",
    "attack_02_stab_fastest",
    "attack_03",
    "attack_03_fast",      
    "attack_03_faster",
    "attack_03_fastest",
    "attack_03_stab",
    "attack_03_stab_fast",
    "attack_03_stab_faster",
    "attack_03_stab_fastest",
    "attack_1",
    "attack_1_fast",
    "attack_1_faster",
    "attack_1_fastest",
    "attack_1_stab",
    "attack_1_stab_fast",
    "attack_1_stab_faster",
    "attack_1_stab_fastest",
    "attack_2",
    "attack_2_fast",
    "attack_2_faster",
    "attack_2_fastest",
    "attack_2_stab",
    "attack_2_stab_fast",
    "attack_2_stab_faster",
    "attack_2_stab_fastest",
    "attack_3",
    "attack_3_fast",      
    "attack_3_faster",
    "attack_3_fastest",
    "attack_3_stab",
    "attack_3_stab_fast",
    "attack_3_stab_faster",
    "attack_3_stab_fastest",
    "attack_alt1_anim",
    "attack_alt_a_anim",
    "attack_alt_b_anim",
    "attack_alt_c_anim",
    "attack_alt_d_anim",
    "attack_anim",
    "attack_fast",
    "attack_faster",
    "attack_fastest",
    "attack_stab",
    "attack_stab_fast",
    "attack_stab_faster",
    "attack_stab_fastest",
    "attackfast",
    "attackfaster",
    "attackfastest",
    "attackstab",
    "attackstab_fast",
    "attackstab_faster",
    "attackstab_fastest",
    "phantom_assassin_attack_alt1_anim",
    "phantom_assassin_attack_anim"
}

function AutoCrit.OnGameStart()
    AutoCrit.CritMode = 0
    AutoCrit.NPCs = {}
end

function AutoCrit.OnUnitAnimation(animation)
    if not animation then return end


    for i, v in ipairs(AutoCrit.HeroList) do
        if NPC.GetUnitName(animation.unit) == v then
            for k, v in pairs(animation) do
                Log.Write(tostring(k) .. " : " .. tostring(v))
            end
        end
    end

    for i, v in ipairs(AutoCrit.HeroList) do
        if NPC.GetUnitName(animation.unit) == v then
            if AutoCrit.CritMode == 1 then
                for i, v in ipairs(AutoCrit.NormalAnimationList) do
                    if animation.sequenceName == v then
                        for k, v in ipairs(AutoCrit.NPCs) do
                            if v[1] == animation.unit then
                                table.remove(AutoCrit.NPCs, k)
                            end
                        end

                        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_STOP, nil, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, animation.unit, false)
                        local increasedAS = NPC.GetIncreasedAttackSpeed(animation.unit)
                        local attackTime = NPC.GetAttackTime(animation.unit)
                        local attackPoint = .30
                        local baseAttackSpeed = 123
                        if NPC.GetUnitName(animation.unit) == "npc_dota_hero_phantom_assassin" then
                            attackPoint = .30
                            baseAttackSpeed = 123
                            -- 0.0592
                        elseif NPC.GetUnitName(animation.unit) == "npc_dota_hero_skeleton_king" then 
                            attackPoint = .56
                            baseAttackSpeed = 118
                            -- 0.1069
                        elseif NPC.GetUnitName(animation.unit) == "npc_dota_hero_juggernaut" then 
                            attackPoint = .33
                            baseAttackSpeed = 147
                            -- 0.0749
                        elseif NPC.GetUnitName(animation.unit) == "npc_dota_hero_chaos_knight" then  
                            attackPoint = .50
                            baseAttackSpeed = 114
                            -- 0.0928
                        elseif NPC.GetUnitName(animation.unit) == "npc_dota_hero_brewmaster" then  
                            attackPoint = .35
                            baseAttackSpeed = 122
                            -- 0.0668
                        elseif NPC.GetUnitName(animation.unit) == "npc_dota_hero_pangolier" then  
                            attackPoint = .34
                            baseAttackSpeed = 118
                            -- 0.0649
                        elseif NPC.GetUnitName(animation.unit) == "npc_dota_hero_morphling" then  
                            attackPoint = .51
                            baseAttackSpeed = 137
                            -- unknown
                        elseif NPC.GetUnitName(animation.unit) == "npc_dota_hero_bounty_hunter" then  
                            attackPoint = .59
                            baseAttackSpeed = 121
                            -- 0.1149
                        end
                        local attackPoint = attackPoint / (1 + increasedAS/baseAttackSpeed)
                        local attackTime = GameRules.GetGameTime() + animation.castpoint + attackPoint     
                        table.insert(AutoCrit.NPCs, {animation.unit, GameRules.GetGameTime(), attackTime})
                    end
                end
            end
        end
    end
end

function AutoCrit.OnUpdate()
    if not Heroes.GetLocal() then return end
    local myHero = Heroes.GetLocal()
    for i, v in ipairs(AutoCrit.HeroList) do
        if Menu.IsKeyDownOnce(AutoCrit.CritKey) then
            if AutoCrit.CritMode == 1 then
                AutoCrit.CritMode = 0
            else
                AutoCrit.CritMode = 1
            end
        end
    
        if AutoCrit.CritMode == 1 then
            for k, v in ipairs(AutoCrit.NPCs) do
                if v[1] and v[2] and v[3] then
                    if not Entity.IsAlive(v[1]) then
                        table.remove(AutoCrit.NPCs, k)
                    elseif GameRules.GetGameTime() >= v[3] then
                        local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
                        if enemy and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemy), NPC.GetAttackRange(myHero)+300) then
                            Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, enemy, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, v[1], false)
                        else
                            Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, nil, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, v[1], false)
                        end
                        table.remove(AutoCrit.NPCs, k)
                    end
                end
            end
        end
    end
end

function AutoCrit.OnDraw()
    if not GameRules.GetGameState() == 5 then return end
    if not Heroes.GetLocal() then return end
    local myHero = Heroes.GetLocal()

    local pos = NPC.GetAbsOrigin(myHero)
    local x, y, visible = Renderer.WorldToScreen(pos)

    if visible and pos and AutoCrit.CritMode == 1 then
      Renderer.SetDrawColor(255, 255, 255, 255)
      Renderer.DrawText(AutoCrit.Font, x+15, y+15, "Crit", 1)
    end
end


return AutoCrit