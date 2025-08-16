local VladMythicPlusDelves = CreateFrame("Frame")
VladMythicPlusDelves:RegisterEvent("ADDON_LOADED")
VladMythicPlusDelves:RegisterEvent("PLAYER_REGEN_DISABLED")
VladMythicPlusDelves:RegisterEvent("PLAYER_REGEN_ENABLED")

local G = {
    MapTeleports = {
        { spellID = 354462, mapID = 376, name = "The Necrotic Wake" },
        { spellID = 354463, mapID = 379, name = "Plaguefall" },
        { spellID = 354464, mapID = 375, name = "Mists of Tirna Scithe" },
        { spellID = 354465, mapID = 378, name = "Halls of Atonement" },
        { spellID = 354466, mapID = 381, name = "Spires of Ascension" },
        { spellID = 354467, mapID = 382, name = "Theater of Pain" },
        { spellID = 354468, mapID = 377, name = "De Other Side" },
        { spellID = 354469, mapID = 380, name = "Sanguine Depths" },
        { spellID = 367416, mapID = 392, name = "Tazavesh: So'leah's Gambit" },
        { spellID = 367416, mapID = 391, name = "Tazavesh: Streets of Wonder" },
        { spellID = 373274, mapID = 370, name = "Operation: Mechagon - Workshop" },
        { spellID = 373274, mapID = 369, name = "Operation: Mechagon - Junkyard" },
        { spellID = 410071, mapID = 245, name = "Freehold" },
        { spellID = 410074, mapID = 251, name = "The Underrot" },
        { spellID = 424167, mapID = 248, name = "Waycrest Manor" },
        { spellID = 424187, mapID = 244, name = "Atal'Dazar" },
        { spellID = 445418, mapID = 353, name = "Siege of Boralus" },
        { spellID = 464256, mapID = 353, name = "Siege of Boralus" },
        { spellID = 373262, mapID = 234, name = "Return to Karazhan: Upper" },
        { spellID = 373262, mapID = 227, name = "Return to Karazhan: Lower" },
        { spellID = 393764, mapID = 200, name = "Halls of Valor" },
        { spellID = 393766, mapID = 210, name = "Court of Stars" },
        { spellID = 410078, mapID = 206, name = "Neltharion's Lair" },
        { spellID = 424153, mapID = 199, name = "Black Rook Hold" },
        { spellID = 424163, mapID = 198, name = "Darkheart Thicket" },
        { spellID = 393222, mapID = 403, name = "Uldaman: Legacy of Tyr" },
        { spellID = 393256, mapID = 399, name = "Ruby Life Pools" },
        { spellID = 393262, mapID = 400, name = "The Nokhud Offensive" },
        { spellID = 393267, mapID = 405, name = "Brackenhide Hollow" },
        { spellID = 393273, mapID = 402, name = "Algeth'ar Academy" },
        { spellID = 393276, mapID = 404, name = "Neltharus" },
        { spellID = 393279, mapID = 401, name = "The Azure Vault" },
        { spellID = 393283, mapID = 406, name = "Halls of Infusion" },
        { spellID = 424197, mapID = 463, name = "Dawn of the Infinite: Galakrond's Fall" },
        { spellID = 424197, mapID = 464, name = "Dawn of the Infinite: Murozond's Rise" },
        { spellID = 410080, mapID = 438, name = "The Vortex Pinnacle" },
        { spellID = 424142, mapID = 456, name = "Throne of the Tides" },
        { spellID = 445424, mapID = 507, name = "Grim Batol" },
        { spellID = 445269, mapID = 501, name = "The Stonevault" },
        { spellID = 445414, mapID = 505, name = "The Dawnbreaker" },
        { spellID = 445416, mapID = 502, name = "City of Threads" },
        { spellID = 445417, mapID = 503, name = "Ara-Kara, City of Echoes" },
        { spellID = 445440, mapID = 506, name = "Cinderbrew Meadery" },
        { spellID = 445441, mapID = 504, name = "Darkflame Cleft" },
        { spellID = 445443, mapID = 500, name = "The Rookery" },
        { spellID = 445444, mapID = 499, name = "Priory of the Sacred Flame" },
        { spellID = 131204, mapID = 2, name = "Temple of the Jade Serpent" },
        { spellID = 131205, mapID = 56, name = "Stormstout Brewery" },
        { spellID = 131206, mapID = 58, name = "Shado-Pan Monastery" },
        { spellID = 131222, mapID = 60, name = "Mogu'shan Palace" },
        { spellID = 131225, mapID = 57, name = "Gate of the Setting Sun" },
        { spellID = 131228, mapID = 59, name = "Siege of Niuzao Temple" },
        { spellID = 131229, mapID = 78, name = "Scarlet Monastery" },
        { spellID = 131231, mapID = 77, name = "Scarlet Halls" },
        { spellID = 131232, mapID = 76, name = "Scholomance" },
        { spellID = 159895, mapID = 163, name = "Bloodmaul Slag Mines" },
        { spellID = 159896, mapID = 169, name = "Iron Docks" },
        { spellID = 159897, mapID = 164, name = "Auchindoun" },
        { spellID = 159898, mapID = 161, name = "Skyreach" },
        { spellID = 159899, mapID = 165, name = "Shadowmoon Burial Grounds" },
        { spellID = 159900, mapID = 166, name = "Grimrail Depot" },
        { spellID = 159901, mapID = 168, name = "The Everbloom" },
        { spellID = 159902, mapID = 167, name = "Upper Blackrock Spire" },
        { spellID = 1216786, mapID = 525, name = "Operation: Floodgate" },
        { spellID = 467553, mapID = 247, name = "The MOTHERLODE!!" },
        { spellID = 367416, mapID = 391, name = "Streets of Wonder" },
        { spellID = 367416, mapID = 392, name = "So'leah's Gambit" },
        { spellID = 1237215, mapID = 542, name = "Eco-Dome Al'dani" },	
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