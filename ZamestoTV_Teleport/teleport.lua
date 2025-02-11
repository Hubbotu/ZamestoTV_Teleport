local VladMythicPlusDelves = CreateFrame("Frame")
VladMythicPlusDelves:RegisterEvent("ADDON_LOADED")
VladMythicPlusDelves:RegisterEvent("PLAYER_REGEN_DISABLED")
VladMythicPlusDelves:RegisterEvent("PLAYER_REGEN_ENABLED")

local G = {
    MapTeleports = {
        { spellID = 354462, mapID = 376 },
        { spellID = 354463, mapID = 379 },
        { spellID = 354464, mapID = 375 },
        { spellID = 354465, mapID = 378 },
        { spellID = 354466, mapID = 381 },
        { spellID = 354467, mapID = 382 },
        { spellID = 354468, mapID = 377 },
        { spellID = 354469, mapID = 380 },
        { spellID = 367416, mapID = 392 },
        { spellID = 367416, mapID = 391 },
        { spellID = 373274, mapID = 370 },
        { spellID = 373274, mapID = 369 },
        { spellID = 410071, mapID = 245 },
        { spellID = 410074, mapID = 251 },
        { spellID = 424167, mapID = 248 },
        { spellID = 424187, mapID = 244 },
        { spellID = 445418, mapID = 353 },
        { spellID = 464256, mapID = 353 },
        { spellID = 373262, mapID = 234 },
        { spellID = 373262, mapID = 227 },
        { spellID = 393764, mapID = 200 },
        { spellID = 393766, mapID = 210 },
        { spellID = 410078, mapID = 206 },
        { spellID = 424153, mapID = 199 },
        { spellID = 424163, mapID = 198 },
        { spellID = 393222, mapID = 403 },
        { spellID = 393256, mapID = 399 },
        { spellID = 393262, mapID = 400 },
        { spellID = 393267, mapID = 405 },
        { spellID = 393273, mapID = 402 },
        { spellID = 393276, mapID = 404 },
        { spellID = 393279, mapID = 401 },
        { spellID = 393283, mapID = 406 },
        { spellID = 424197, mapID = 463 },
        { spellID = 424197, mapID = 464 },
        { spellID = 410080, mapID = 438 },
        { spellID = 424142, mapID = 456 },
        { spellID = 445424, mapID = 507 },
        { spellID = 445269, mapID = 501 },
        { spellID = 445414, mapID = 505 },
        { spellID = 445416, mapID = 502 },
        { spellID = 445417, mapID = 503 },
        { spellID = 445440, mapID = 506 },
        { spellID = 445441, mapID = 504 },
        { spellID = 445443, mapID = 500 },
        { spellID = 445444, mapID = 499 },
        { spellID = 131204, mapID = 2 },
        { spellID = 131205, mapID = 56 },
        { spellID = 131206, mapID = 58 },
        { spellID = 131222, mapID = 60 },
        { spellID = 131225, mapID = 57 },
        { spellID = 131228, mapID = 59 },
        { spellID = 131229, mapID = 78 },
        { spellID = 131231, mapID = 77 },
        { spellID = 131232, mapID = 76 },
        { spellID = 159895, mapID = 163 },
        { spellID = 159896, mapID = 169 },
        { spellID = 159897, mapID = 164 },
        { spellID = 159898, mapID = 161 },
        { spellID = 159899, mapID = 165 },
        { spellID = 159900, mapID = 166 },
        { spellID = 159901, mapID = 168 },
        { spellID = 159902, mapID = 167 },
    },
    KeystoneTeleportButtons = {},
    config = {
        taintSafe = false
    }
}

function G.GetMapTeleports(mapID)
    local temp = {}
    for _, info in ipairs(G.MapTeleports) do
        if info.mapID == mapID then
            temp[#temp + 1] = info.spellID
        end
    end
    return temp
end

function G.GetKnownSpells(spells)
    local temp = {}
    for _, spellID in ipairs(spells) do
        if IsSpellKnown(spellID) then
            temp[#temp + 1] = spellID
        end
    end
    return temp[1], temp
end

local function OnTeleportEnter(self)
    local spellName = self:GetAttribute("spell")
    local cdInfo = C_Spell.GetSpellCooldown(spellName)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
    GameTooltip:AddLine("Teleport", 1, 1, 1, true)
    
    if cdInfo.startTime ~= 0 then
        local remaining = cdInfo.startTime + cdInfo.duration - GetTime()
        GameTooltip:AddLine(SecondsToTime(remaining), 1, 1, 1, true)
    end
    GameTooltip:Show()
end

function G.CreateKeystoneTeleportButton(frame)
    local button = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
    button:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
    button:SetSize(24, 24)
    button:SetAttribute("type", "spell")
    button:SetAttribute("spell", "")
    button:RegisterForClicks("AnyUp", "AnyDown")
    button.Icon = button:CreateTexture(nil, "OVERLAY")
    button.Icon:SetAllPoints()
    button.Icon:SetAtlas("Dungeon")
    button.Cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
    button.Cooldown:SetAllPoints()
    button.Cooldown:SetHideCountdownNumbers(true)
    button.Cooldown:SetDrawSwipe(false)
    button.Cooldown:SetDrawEdge(true)
    button:HookScript("OnEnter", OnTeleportEnter)
    button:HookScript("OnLeave", GameTooltip_Hide)
    return button
end

function G.KeystonesUpdate(self)
    if InCombatLockdown() then
        return
    end
    for _, button in pairs(G.KeystoneTeleportButtons) do
        button:Hide()
    end
    for i = 1, #self.maps do
        local frame = self.DungeonIcons[i]
        local name = C_ChallengeMode.GetMapUIInfo(frame.mapID)
        local teleports = G.GetMapTeleports(frame.mapID)
        local spell = G.GetKnownSpells(teleports)
        local button = G.KeystoneTeleportButtons[i]
        if spell and not button then
            button = G.CreateKeystoneTeleportButton(frame)
            G.KeystoneTeleportButtons[i] = button
        end
        if spell and button then
            local info = C_Spell.GetSpellInfo(spell)
            button:SetAttribute("spell", info.name)
            local cdInfo = C_Spell.GetSpellCooldown(spell)
            button.Cooldown:SetCooldown(cdInfo.startTime, cdInfo.duration, cdInfo.modRate)
        end
        if button then
            button:SetShown(spell)
        end
    end
end

function G.KeystonesInit()
    hooksecurefunc(ChallengesFrame, "Update", function(...) G.KeystonesUpdate(...) end)
end

function G.TryLoad()
    if InCombatLockdown() then
        return
    end
    if ChallengesFrame and not G.Keystones then
        G.Keystones = true
        G.KeystonesInit()
    end
end

VladMythicPlusDelves:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        G.TryLoad()
    elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
        G.TryLoad()
    end
end)
