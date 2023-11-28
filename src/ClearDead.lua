function clearCTDead(sClearType)
    local nCombatants = CombatManager.getCombatantNodes();
    local nCurrentInit = CombatManager.getActiveCT();
    for _, v in pairs(nCombatants) do
        local sType, nNode = ActorManager.getTypeAndNode(v)
        local sFaction = ActorManager.getFaction(v)
        local bDelete = false;
        if sClearType == "all" or sFaction == "foe" then
            bDelete = true;
        end
        if sType == "ct" and bDelete and isDead(nNode) then
            delCTEntry(nNode, nCurrentInit)
        end
    end
end

function delCTEntry(nNode, nCurrentInit)
    if not nNode then
        return;
    end
    DB.deleteChildren(nNode, "effects");
    DB.setValue(nNode, "wounds", "number", 0);
    if nNode == nCurrentInit then
        CombatManager.nextActor();
    end
    nNode.delete()
end

function isDead(nNode)
    local sStatus = "";
    if Session.RulesetName == "5E" then
        _, sStatus = ActorManager5E.getWoundPercent(nNode);
        if sStatus == "Dead" or sStatus == "Dying" then
            return true;
        end
    elseif Session.RulesetName == "4E" then
        _, sStatus = ActorManager4E.getWoundPercent(nNode);
        if sStatus == "Dead" or sStatus == "Dying" then
            return true;
        end
    elseif Session.RulesetName == "3.5E" then
        _, sStatus, _ = ActorManager35E.getWoundPercent(nNode);
        if sStatus == "Dead" or sStatus == "Dying" then
            return true;
        end
    elseif Session.RulesetName == "PFRPG" then
        _, sStatus, _ = ActorManager35E.getWoundPercent(nNode);
        if sStatus == "Dead" or sStatus == "Dying" then
            return true;
        end
    elseif Session.RulesetName == "PFRPG2" then
        _, sStatus, _ = ActorManager2.getWoundPercent(nNode);
        if sStatus == "Dead" or sStatus == "Dying" then
            return true;
        end
    elseif Session.RulesetName == "OSE2" then
        _, sStatus = manager_actor_OSE.getWoundPercent(nNode);
        if sStatus == "Dead" or sStatus == "Dying" then
            return true;
        end
    elseif Session.RulesetName == "DCC RPG" then
        _, sStatus = ActorManagerDCC.getWoundPercent(nNode);
        if sStatus == "Dead" or sStatus == "Dying" then
            return true;
        end
    elseif Session.RulesetName == "MCC RPG" then
        _, sStatus = ActorManagerMCC.getWoundPercent(nNode);
        if sStatus == "Dead" or sStatus == "Dying" then
            return true;
        end
    end
    return false;
end
