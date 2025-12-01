local addon, addonName = ...
local chatShown = false

-- Create button to toggle chat visibility
local chatToggleButton = CreateFrame("Button", "GuildChatToggleButton", CommunitiesFrame,"UIPanelButtonTemplate")
--chatToggleButton:SetSize(100, 22)
chatToggleButton:SetPoint("CENTER", CommunitiesFrame.CommunitiesControlFrame, "CENTER", 0, 0)
if(CommunitiesFrame.Chat.MessageFrame:IsShown()) then
    chatToggleButton:SetText("Hide Chat")
else
    chatToggleButton:SetText("Show Chat")
end

-- Functions
local function PositionToggleButton()
    if not CommunitiesFrame or not CommunitiesFrame.CommunitiesControlFrame then return end

    local control = CommunitiesFrame.CommunitiesControlFrame
    local settings = control.CommunitiesSettingsButton
    local recruit  = control.GuildRecruitmentButton

    -- prefer Settings if it exists & is shown, otherwise Recruitment
    local anchor = nil
    if settings and settings:IsShown() then
        anchor = settings
    elseif recruit and recruit:IsShown() then
        anchor = recruit
    end

    if anchor then
        chatToggleButton:ClearAllPoints()

        -- put our button just to the left of the anchor button
        chatToggleButton:SetPoint("RIGHT", anchor, "LEFT", -4, 0)
        chatToggleButton:Show()

        -- size button to match anchor height
        chatToggleButton:SetSize(100, anchor:GetHeight())
    else
        -- nothing to anchor to (weird state) – just hide ourselves
        chatToggleButton:Hide()
    end
end

local function HideGuildChat()
    if CommunitiesFrame
       and CommunitiesFrame.Chat
       and CommunitiesFrame.Chat.MessageFrame then

        CommunitiesFrame.Chat.MessageFrame:Hide()
        PositionToggleButton()
        chatToggleButton:SetText("Show Chat")
        chatShown = false
    end
end

local function ShowGuildChat()
    if CommunitiesFrame.Chat.MessageFrame then
        CommunitiesFrame.Chat.MessageFrame:Show()
        PositionToggleButton()
        chatToggleButton:SetText("Hide Chat")
        chatShown = true
    end
end

local function ToggleGuildChat()
    if chatShown then
        HideGuildChat()
    else
        ShowGuildChat()
    end
end

chatToggleButton:SetScript("OnClick", ToggleGuildChat)

hooksecurefunc(CommunitiesFrame, "SetDisplayMode", HideGuildChat)
hooksecurefunc(CommunitiesFrame, "OnClubSelected", HideGuildChat)
hooksecurefunc(CommunitiesFrame, "Show", HideGuildChat)
