To save them from getting deleted by blizz forums!

```
  
  local hooks = {};
  local range;

  hooks["ActionButton_OnUpdate"] = ActionButton_OnUpdate;
  
  ActionButton_OnUpdate = function(elapsed)
    if ( IsActionInRange(ActionButton_GetPagedID(this)) == 0) then
        getglobal(this:GetName().."Icon"):SetVertexColor(0.2,0.2,0.2);
        getglobal(this:GetName().."NormalTexture"):SetVertexColor(0.2,0.2,0.2);
        range = 1;
	else
        range = 0;
    end
	hooks["ActionButton_OnUpdate"](elapsed);
		
	if (this.range ~= range and range == 0) then
        ActionButton_UpdateUsable()
    end
        this.range = range;
	end
	
```

change multibarbottomright layout

```
  
  local button;
  
  for i = 1, 12, 1 do
    button = _G["MultiBarRightButton"..i];
    button:ClearAllPoints();
    
    if ( i > 1 ) then
      button:SetPoint("LEFT",_G["MultiBarRightButton"..(i-1)],"RIGHT",5,0);
    else
      button:SetPoint("CENTER",UIParent,"CENTER",-290,0);
    end
  end
  
```

hook tooltip
```
  
  hooksecurefunc("GameTooltip_SetDefaultAnchor", function (tooltip, parent)
  tooltip:SetOwner(parent,"ANCHOR_NONE");
  tooltip:SetPoint("CENTER",UIParent,"CENTER",0,0);
  end
  
```