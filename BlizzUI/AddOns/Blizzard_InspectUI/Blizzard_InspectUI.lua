
INSPECTFRAME_SUBFRAMES = { "InspectPaperDollFrame", "InspectPVPFrame", "InspectTalentFrame", "InspectTalentFrame", "InspectTalentFrame" };

UIPanelWindows["InspectFrame"] = { area = "left", pushable = 0 };

function InspectFrame_Show(unit)
	HideUIPanel(InspectFrame);
	if ( CanInspect(unit, true) ) then
		NotifyInspect(unit);
		InspectFrame.unit = unit;
		InspectSwitchTabs(1);
		ShowUIPanel(InspectFrame);
		InspectFrame_UpdateTalentTab();
	end
end

function InspectFrame_OnLoad()
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this.unit = nil;

	-- Tab Handling code
	PanelTemplates_SetNumTabs(this, 3);
	PanelTemplates_SetTab(this, 1);
end

function InspectFrame_OnEvent(event)
	if ( not this:IsShown() ) then
		return;
	end
	if ( event == "PLAYER_TARGET_CHANGED" or event == "PARTY_MEMBERS_CHANGED" ) then
		if ( (event == "PLAYER_TARGET_CHANGED" and this.unit == "target") or
		     (event == "PARTY_MEMBERS_CHANGED" and this.unit ~= "target") ) then
			if ( CanInspect(this.unit) ) then
				InspectFrame_UnitChanged();
			else
				HideUIPanel(InspectFrame);
			end
		end
		return;
	elseif ( event == "UNIT_NAME_UPDATE" ) then
		if ( arg1 == this.unit ) then
			InspectNameText:SetText(UnitName(arg1));
		end
		return;
	elseif ( event == "UNIT_PORTRAIT_UPDATE" ) then
		if ( arg1 == this.unit ) then
			SetPortraitTexture(InspectFramePortrait, arg1);
		end
		return;
	end
end

function InspectFrame_UnitChanged()
	local unit = this.unit;
	NotifyInspect(unit);
	InspectPaperDollFrame_OnShow();
	SetPortraitTexture(InspectFramePortrait, unit);
	InspectNameText:SetText(UnitName(unit));
	InspectFrame_UpdateTalentTab();
	if ( InspectPVPFrame:IsShown() ) then
		InspectPVPFrame_OnShow();
	end
end

function InspectFrame_OnShow()
	if ( not this.unit ) then
		return;
	end
	PlaySound("igCharacterInfoOpen");	
	SetPortraitTexture(InspectFramePortrait, this.unit);
	InspectNameText:SetText(UnitName(this.unit));
end

function InspectFrame_OnHide()
	this.unit = nil;
	PlaySound("igCharacterInfoClose");

	-- Clear the player being inspected
	ClearInspectPlayer();
end

function InspectFrame_OnUpdate()
	if ( not UnitIsVisible(this.unit) ) then
		HideUIPanel(InspectFrame);
	end
end		

function InspectSwitchTabs(newID)
	local newFrame = getglobal(INSPECTFRAME_SUBFRAMES[newID]);
	local oldFrame = getglobal(INSPECTFRAME_SUBFRAMES[PanelTemplates_GetSelectedTab(InspectFrame)]);
	if ( newFrame ) then
		if ( oldFrame ) then
			oldFrame:Hide();
		end
		PanelTemplates_SetTab(InspectFrame, newID);
		ShowUIPanel(InspectFrame);
		newFrame:Show();
	end
end

function InspectFrameTab_OnClick()
	PlaySound("igCharacterInfoTab");
	InspectSwitchTabs(this:GetID());
end

function InspectFrame_UpdateTalentTab()
	if ( not InspectFrame.unit ) then
		return;
	end
	local level = UnitLevel(InspectFrame.unit);
	if ( level > 0 and level < 10 ) then
		PanelTemplates_DisableTab(InspectFrame, 3);
		if ( PanelTemplates_GetSelectedTab(InspectFrame) == 3 ) then
			InspectSwitchTabs(1);
		end
	else
		PanelTemplates_EnableTab(InspectFrame, 3);
		InspectTalentFrame_SetupTabs();
	end
end
