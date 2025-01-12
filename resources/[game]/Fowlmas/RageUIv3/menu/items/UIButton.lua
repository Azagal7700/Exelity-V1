---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---Button
---@param Label string
---@param Description string
---@param Enabled boolean
---@param Callback function
---@param Submenu table
---@return nil
---@public
function RageUIv3.Button(Label, Description, Style, Enabled, Callback, Submenu)
    ---@type table
    local CurrentMenu = RageUIv3.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu() then

            ---@type number
            local Option = RageUIv3.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                ---@type boolean
                local Selected = CurrentMenu.Index == Option

                RageUIv3.ItemsSafeZone(CurrentMenu)

                local LeftBadgeOffset = ((Style.LeftBadge == RageUIv3.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
                local RightBadgeOffset = ((Style.RightBadge == RageUIv3.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)

                local Hovered = false;
                if Style.Color ~= nil then
                    if Style.Color.BackgroundColor ~= nil then
                        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, Style.Color.BackgroundColor[1], Style.Color.BackgroundColor[2], Style.Color.BackgroundColor[3])
                    end
                end

                ---@type boolean
                if CurrentMenu.EnableMouse == true then
                    Hovered = RageUIv3.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end

                if Selected then
                    if Style.Color == nil then
                        RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                    end

                    if Style.Color ~= nil and Style.Color.HightLightColor ~= nil then
                        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, Style.Color.HightLightColor[1], Style.Color.HightLightColor[2], Style.Color.HightLightColor[3])
                    else
                        RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                    end
                end

                if type(Style) == 'table' then
                    if Style.LeftBadge ~= nil then
                        if Style.LeftBadge ~= RageUIv3.BadgeStyle.None and Style.LeftBadge ~= nil then
                            local LeftBadge = Style.LeftBadge(Selected)
                            RenderSprite(LeftBadge.BadgeDictionary or "commonmenu", LeftBadge.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, LeftBadge.BadgeColour and LeftBadge.BadgeColour.R or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.G or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.B or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.A or 255)
                        end
                    end

                    if Style.RightBadge ~= nil then
                        if Style.RightBadge ~= RageUIv3.BadgeStyle.None then
                            local RightBadge = Style.RightBadge(Selected)
                            RenderSprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
                        end
                    end
                end

                if Enabled == true or Enabled == nil then
                    if Selected then
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, 0, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)
                        end
                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, 0, SettingsButton.Text.Scale, 0, 0, 0, 255)
                    else
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, 0, SettingsButton.RightText.Scale, 245, 245, 245, 255, 2)
                        end

                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255)
                    end
                else
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)
                end

                RageUIv3.ItemOffset = RageUIv3.ItemOffset + SettingsButton.Rectangle.Height

                RageUIv3.ItemsDescription(CurrentMenu, Description, Selected);

                if (Enabled) then
                    Callback(Hovered, Selected, ((CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and Selected))
                end

                if Selected and (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) then
                    local Audio = RageUIv3.Settings.Audio
                    RageUIv3.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                    if Submenu ~= nil then
                        if Submenu() then
                            RageUIv3.NextMenu = Submenu
                        end
                    end
                end
            end

            RageUIv3.Options = RageUIv3.Options + 1
        end
    end
end

function RageUIv3.Separator(Label)
    local CurrentMenu = RageUIv3.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = RageUIv3.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                if (Label ~= nil) then
                    --print(CurrentMenu.WidthOffset * 2.5)
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 200), CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255, 1)
                end
                RageUIv3.ItemOffset = RageUIv3.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (RageUIv3.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUIv3.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUIv3.Options = RageUIv3.Options + 1
        end
    end
end
