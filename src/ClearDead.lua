function clearCTDead(sClearType)
    local nCombatants = CombatManager.getCombatantNodes();

    for _, v in pairs(nCombatants) do
        local sType, nNode = ActorManager.getTypeAndNode(v)
        local sFaction = ActorManager.getFaction(v)
        local bDelete = false;

        if sClearType == "all" or sFaction == "foe" then
            bDelete = true;
        end

        if sType == "ct" and bDelete and ActorHealthManager.isDyingOrDead(nNode) then
            CombatManager.deleteCombatant(nNode)
        end
    end
end
