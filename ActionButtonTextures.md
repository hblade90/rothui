Nochmal eine kleine aber imo wichtige Liste zu den ActionButtons.

Daten stammen aus der XML Datei:
  * http://wdnaddons.com/2337799/FrameXML/ActionButtonTemplate.xml


$parent entspricht dem Button, also zum Beispeil BonusActionButton2

$parent = BonusActionButton2

  * Element: $parentIcon
  * Textur: Entspricht der Icon Textur
  * Level: Background

  * Element: $parentFlash
  * Textur: Interface\Buttons\UI-QuickslotRed
  * Level: Artwork

  * Element: $parentBorder
  * Textur: Interface\Buttons\UI-ActionButton-Border
  * Level: Overlay

  * Element: $parentNormalTexture
  * Textur: Interface\Buttons\UI-Quickslot2
  * Level: -

Kommen wir zu Pushed, Checked und Highlight.

Diese lassen sich nicht direkt mit einem Framenamen ansprechen, aber mit einem eigenen Lua-Befehl. Das ist doch auch was.`

```
<PushedTexture file="Interface\Buttons\UI-Quickslot-Depress"/>
<HighlightTexture alphaMode="ADD" file="Interface\Buttons\ButtonHilight-Square"/>
<CheckedTexture alphaMode="ADD" file="Interface\Buttons\CheckButtonHilight"/>
```

Button:SetPushedTexture(texture or "texturePath") - Set the pushed texture for the Button
Button:SetHighlightTexture(texture or "texturePath") - Set the highlight texture for the Button
CheckButton:SetCheckedTexture(texture) - Set the texture to use for a checked box.

Sieht dann ca so aus:

```
bu = _G["BonusActionButton2"]

bu:SetPushedTexture("Interface\\AddOns\\MeinTexturOrdner\\meinePushedTextur")
bu:SetHighlightTexture("Interface\\AddOns\\MeinTexturOrdner\\meineHighlightTextur")
bu:SetCheckedTexture("Interface\\AddOns\\MeinTexturOrdner\\meineCheckedTextur")
```

um z.b. die Flash Textur zu ändern macht man das ganze so:

```
bu_fl = _G["BonusActionButton2Flash"]

bu_fl:SetTexture("Interface\\AddOns\\MeinTexturOrdner\\meineFlashTextur")
```

Das gute daran ist, jetzt können sogar TGA Files verwendet werden.

"meinePushedTextur" kann z.b. eine TGA Datei sein, WoW versteht das.