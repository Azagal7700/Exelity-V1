---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 21/04/2019 21:20
---
---round
---@param num number
---@param numDecimalPlaces number
---@return number
---@public
function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

---starts
---@param String string
---@param Start number
---@return number
---@public
function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@type table
RageUIJob.Menus = setmetatable({}, RageUIJob.Menus)

---@type table
---@return boolean
RageUIJob.Menus.__call = function()
    return true
end

---@type table
RageUIJob.Menus.__index = RageUIJob.Menus

---@type table
RageUIJob.CurrentMenu = nil

---@type table
RageUIJob.NextMenu = nil

---@type number
RageUIJob.Options = 0

---@type number
RageUIJob.ItemOffset = 0

---@type number
RageUIJob.StatisticPanelCount = 0

---@type table
RageUIJob.UI = {
    Current = "RageUI",
    Style = {
        RageUI = {
            Width = 0
        },
        NativeUI = {
            Width = 0
        }
    }
}

---@type table
RageUIJob.Settings = {
    Debug = false,
    Controls = {
        Up = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 172 },
                { 1, 172 },
                { 2, 172 },
                { 0, 241 },
                { 1, 241 },
                { 2, 241 },
            },
        },
        Down = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 173 },
                { 1, 173 },
                { 2, 173 },
                { 0, 242 },
                { 1, 242 },
                { 2, 242 },
            },
        },
        Left = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        Right = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        SliderLeft = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        SliderRight = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        Select = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 201 },
                { 1, 201 },
                { 2, 201 },
            },
        },
        Back = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 177 },
                { 1, 177 },
                { 2, 177 },
                { 0, 199 },
                { 1, 199 },
                { 2, 199 },
            },
        },
        Click = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 24 },
            },
        },
        Enabled = {
            Controller = {
                { 0, 2 }, -- Look Up and Down
                { 0, 1 }, -- Look Left and Right
                { 0, 25 }, -- Aim
                { 0, 24 }, -- Attack
            },
            Keyboard = {
                { 0, 201 }, -- Select
                { 0, 195 }, -- X axis
                { 0, 196 }, -- Y axis
                { 0, 187 }, -- Down
                { 0, 188 }, -- Up
                { 0, 189 }, -- Left
                { 0, 190 }, -- Right
                { 0, 202 }, -- Back
                { 0, 217 }, -- Select
                { 0, 242 }, -- Scroll down
                { 0, 241 }, -- Scroll up
                { 0, 239 }, -- Cursor X
                { 0, 240 }, -- Cursor Y
                { 0, 31 }, -- Move Up and Down
                { 0, 30 }, -- Move Left and Right
                { 0, 21 }, -- Sprint
                { 0, 22 }, -- Jump
                { 0, 23 }, -- Enter
                { 0, 75 }, -- Exit Vehicle
                { 0, 71 }, -- Accelerate Vehicle
                { 0, 72 }, -- Vehicle Brake
                { 0, 59 }, -- Move Vehicle Left and Right
                { 0, 89 }, -- Fly Yaw Left
                { 0, 9 }, -- Fly Left and Right
                { 0, 8 }, -- Fly Up and Down
                { 0, 90 }, -- Fly Yaw Right
                { 0, 76 }, -- Vehicle Handbrake
            },
        },
    },
    Audio = {
        Id = nil,
        Use = "RageUI",
        RageUI = {
            UpDown = {
                audioName = "HUD_FREEMODE_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        },
        NativeUI = {
            UpDown = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        }
    },
    Items = {
        Title = {
            Background = { Width = 431, Height = 107 },
            Text = { X = 215, Y = 20, Scale = 1.15 },
        },
        Subtitle = {
            Background = { Width = 431, Height = 37 },
            Text = { X = 8, Y = 3, Scale = 0.35 },
            PreText = { X = 425, Y = 3, Scale = 0.35 },
        },
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 431 },
        Navigation = {
            Rectangle = { Width = 431, Height = 18 },
            Offset = 5,
            Arrows = { Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 190, Y = -6, Width = 50, Height = 50 },
        },
        Description = {
            Bar = { Y = 4, Width = 431, Height = 4 },
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 30 },
            Text = { X = 8, Y = 10, Scale = 0.35 },
        },
    },
    Panels = {
        Grid = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
            Grid = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", X = 115.5, Y = 47.5, Width = 200, Height = 200 },
            Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
            Text = {
                Top = { X = 215.5, Y = 15, Scale = 0.35 },
                Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
                Left = { X = 57.75, Y = 130, Scale = 0.35 },
                Right = { X = 373.25, Y = 130, Scale = 0.35 },
            },
        },
        Percentage = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76 },
            Bar = { X = 9, Y = 50, Width = 413, Height = 10 },
            Text = {
                Left = { X = 25, Y = 15, Scale = 0.35 },
                Middle = { X = 215.5, Y = 15, Scale = 0.35 },
                Right = { X = 398, Y = 15, Scale = 0.35 },
            },
        },
    },
}

function RageUIJob.SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

---Visible
---@param Menu function
---@param Value boolean
---@return table
---@public
function RageUIJob.Visible(Menu, Value)
    if Menu ~= nil then
        if Menu() then
            if type(Value) == "boolean" then
                if Value then
                    if RageUIJob.CurrentMenu ~= nil then
			if RageUIJob.CurrentMenu.Closed ~= nil then
                            RageUIJob.CurrentMenu.Closed()
                        end
                        RageUIJob.CurrentMenu.Open = not Value
                    end
                    Menu:UpdateInstructionalButtons(Value);
                    Menu:UpdateCursorStyle();
                    RageUIJob.CurrentMenu = Menu
                    menuOpen = true
                else
                    menuOpen = false
                    RageUIJob.CurrentMenu = nil
                end
                Menu.Open = Value
                RageUIJob.Options = 0
                RageUIJob.ItemOffset = 0
                RageUIJob.LastControl = false
            else
                return Menu.Open
            end
        end
    end
end

function RageUIJob.CloseAll()
    menuOpen = false
    if RageUIJob.CurrentMenu ~= nil then
        local parent = RageUIJob.CurrentMenu.Parent
        while parent ~= nil do
            parent.Index = 1
            parent.Pagination.Minimum = 1
            parent.Pagination.Maximum = 10
            parent = parent.Parent
        end
        RageUIJob.CurrentMenu.Index = 1
        RageUIJob.CurrentMenu.Pagination.Minimum = 1
        RageUIJob.CurrentMenu.Pagination.Maximum = 10
        RageUIJob.CurrentMenu.Open = false
        RageUIJob.CurrentMenu = nil
    end
    RageUIJob.Options = 0
    RageUIJob.ItemOffset = 0
    ResetScriptGfxAlign()
end

---Banner
---@return nil
---@public
---@param Enabled boolean
function RageUIJob.Banner(Enabled, Glare)
    if type(Enabled) == "boolean" then
        if Enabled == true then


            if RageUIJob.CurrentMenu ~= nil then
                if RageUIJob.CurrentMenu() then


                    RageUIJob.ItemsSafeZone(RageUIJob.CurrentMenu)

                    if RageUIJob.CurrentMenu.Sprite then
                        RenderSprite(RageUIJob.CurrentMenu.Sprite.Dictionary, RageUIJob.CurrentMenu.Sprite.Texture, RageUIJob.CurrentMenu.X, RageUIJob.CurrentMenu.Y, RageUIJob.Settings.Items.Title.Background.Width + RageUIJob.CurrentMenu.WidthOffset, RageUIJob.Settings.Items.Title.Background.Height, nil)
                    else
                        RenderRectangle(RageUIJob.CurrentMenu.X, RageUIJob.CurrentMenu.Y, RageUIJob.Settings.Items.Title.Background.Width + RageUIJob.CurrentMenu.WidthOffset, RageUIJob.Settings.Items.Title.Background.Height, RageUIJob.CurrentMenu.Rectangle.R, RageUIJob.CurrentMenu.Rectangle.G, RageUIJob.CurrentMenu.Rectangle.B, RageUIJob.CurrentMenu.Rectangle.A)
                    end

                    --if (RageUIJob.CurrentMenu.WidthOffset == 100) then
                        if Glare then

                            local ScaleformMovie = RequestScaleformMovie("MP_MENU_GLARE")
                            while not HasScaleformMovieLoaded(ScaleformMovie) do
                                Citizen.Wait(0)
                            end

							---@type number
							local Glarewidth = RageUIJob.Settings.Items.Title.Background.Width

							---@type number
							local Glareheight = RageUIJob.Settings.Items.Title.Background.Height
							---@type number
							local GlareX = RageUIJob.CurrentMenu.X / 1860 + (RageUIJob.CurrentMenu.SafeZoneSize.X / (64.399 - (RageUIJob.CurrentMenu.WidthOffset * 0.065731)))
                            ---@type number
                            local GlareY = RageUIJob.CurrentMenu.Y / 1080 + RageUIJob.CurrentMenu.SafeZoneSize.Y / 33.195020746888
                            RageUIJob.SetScaleformParams(ScaleformMovie, {
                                { name = "SET_DATA_SLOT", param = { GetGameplayCamRelativeHeading() } }
                            })

                            DrawScaleformMovie(ScaleformMovie, GlareX, GlareY, Glarewidth / 430, Glareheight / 100, 255, 255, 255, 255, 0)

                        end
                    --end

                    RenderText(RageUIJob.CurrentMenu.Title, RageUIJob.CurrentMenu.X + RageUIJob.Settings.Items.Title.Text.X + (RageUIJob.CurrentMenu.WidthOffset / 2), RageUIJob.CurrentMenu.Y + RageUIJob.Settings.Items.Title.Text.Y, 1, RageUIJob.Settings.Items.Title.Text.Scale, 255, 255, 255, 255, 1)
                    RageUIJob.ItemOffset = RageUIJob.ItemOffset + RageUIJob.Settings.Items.Title.Background.Height
                end
            end
        end
    else
        error("Enabled is not boolean")
    end
end

---CloseAll -- TODO 
---@return nil
---@public
-- function RageUI:CloseAll()
--     RageUIJob.PlaySound(RageUIJob.Settings.Audio.Library, RageUIJob.Settings.Audio.Back)
--     RageUIJob.NextMenu = nil
--     RageUIJob.Visible(RageUIJob.CurrentMenu, false)
-- end

---Subtitle
---@return nil
---@public
function RageUIJob.Subtitle()
    if RageUIJob.CurrentMenu ~= nil then
        if RageUIJob.CurrentMenu() then
            RageUIJob.ItemsSafeZone(RageUIJob.CurrentMenu)
            if RageUIJob.CurrentMenu.Subtitle ~= "" then
                RenderRectangle(RageUIJob.CurrentMenu.X, RageUIJob.CurrentMenu.Y + RageUIJob.ItemOffset, RageUIJob.Settings.Items.Subtitle.Background.Width + RageUIJob.CurrentMenu.WidthOffset, RageUIJob.Settings.Items.Subtitle.Background.Height + RageUIJob.CurrentMenu.SubtitleHeight, 0, 0, 0, 255)
                RenderText(RageUIJob.CurrentMenu.Subtitle, RageUIJob.CurrentMenu.X + RageUIJob.Settings.Items.Subtitle.Text.X, RageUIJob.CurrentMenu.Y + RageUIJob.Settings.Items.Subtitle.Text.Y + RageUIJob.ItemOffset, 0, RageUIJob.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUIJob.Settings.Items.Subtitle.Background.Width + RageUIJob.CurrentMenu.WidthOffset)
                if RageUIJob.CurrentMenu.Index > RageUIJob.CurrentMenu.Options or RageUIJob.CurrentMenu.Index < 0 then
                    RageUIJob.CurrentMenu.Index = 1
                end
                RageUIJob.RefreshPagination()
                if RageUIJob.CurrentMenu.PageCounter == nil then
                    RenderText(RageUIJob.CurrentMenu.PageCounterColour .. RageUIJob.CurrentMenu.Index .. " / " .. RageUIJob.CurrentMenu.Options, RageUIJob.CurrentMenu.X + RageUIJob.Settings.Items.Subtitle.PreText.X + RageUIJob.CurrentMenu.WidthOffset, RageUIJob.CurrentMenu.Y + RageUIJob.Settings.Items.Subtitle.PreText.Y + RageUIJob.ItemOffset, 0, RageUIJob.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                else
                    RenderText(RageUIJob.CurrentMenu.PageCounter, RageUIJob.CurrentMenu.X + RageUIJob.Settings.Items.Subtitle.PreText.X + RageUIJob.CurrentMenu.WidthOffset, RageUIJob.CurrentMenu.Y + RageUIJob.Settings.Items.Subtitle.PreText.Y + RageUIJob.ItemOffset, 0, RageUIJob.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                end
                RageUIJob.ItemOffset = RageUIJob.ItemOffset + RageUIJob.Settings.Items.Subtitle.Background.Height
            end
        end
    end
end

---Background
---@return nil
---@public
function RageUIJob.Background()
    if RageUIJob.CurrentMenu ~= nil then
        if RageUIJob.CurrentMenu() then
            RageUIJob.ItemsSafeZone(RageUIJob.CurrentMenu)
            SetScriptGfxDrawOrder(0)
            RenderSprite(RageUIJob.Settings.Items.Background.Dictionary, RageUIJob.Settings.Items.Background.Texture, RageUIJob.CurrentMenu.X, RageUIJob.CurrentMenu.Y + RageUIJob.Settings.Items.Background.Y + RageUIJob.CurrentMenu.SubtitleHeight, RageUIJob.Settings.Items.Background.Width + RageUIJob.CurrentMenu.WidthOffset, RageUIJob.ItemOffset, 0, 0, 0, 0, 255)
            SetScriptGfxDrawOrder(1)
        end
    end
end

---Description
---@return nil
---@public
function RageUIJob.Description()
    if RageUIJob.CurrentMenu ~= nil and RageUIJob.CurrentMenu.Description ~= nil then
        if RageUIJob.CurrentMenu() then
            RageUIJob.ItemsSafeZone(RageUIJob.CurrentMenu)
            RenderRectangle(RageUIJob.CurrentMenu.X, RageUIJob.CurrentMenu.Y + RageUIJob.Settings.Items.Description.Bar.Y + RageUIJob.CurrentMenu.SubtitleHeight + RageUIJob.ItemOffset, RageUIJob.Settings.Items.Description.Bar.Width + RageUIJob.CurrentMenu.WidthOffset, RageUIJob.Settings.Items.Description.Bar.Height, 0, 0, 0, 255)
            RenderSprite(RageUIJob.Settings.Items.Description.Background.Dictionary, RageUIJob.Settings.Items.Description.Background.Texture, RageUIJob.CurrentMenu.X, RageUIJob.CurrentMenu.Y + RageUIJob.Settings.Items.Description.Background.Y + RageUIJob.CurrentMenu.SubtitleHeight + RageUIJob.ItemOffset, RageUIJob.Settings.Items.Description.Background.Width + RageUIJob.CurrentMenu.WidthOffset, RageUIJob.CurrentMenu.DescriptionHeight, 0, 0, 0, 255)
            RenderText(RageUIJob.CurrentMenu.Description, RageUIJob.CurrentMenu.X + RageUIJob.Settings.Items.Description.Text.X, RageUIJob.CurrentMenu.Y + RageUIJob.Settings.Items.Description.Text.Y + RageUIJob.CurrentMenu.SubtitleHeight + RageUIJob.ItemOffset, 0, RageUIJob.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, RageUIJob.Settings.Items.Description.Background.Width + RageUIJob.CurrentMenu.WidthOffset - 8.0)
            RageUIJob.ItemOffset = RageUIJob.ItemOffset + RageUIJob.CurrentMenu.DescriptionHeight + RageUIJob.Settings.Items.Description.Bar.Y
        end
    end
end

---Render
---@param instructionalButton boolean
---@return nil
---@public
function RageUIJob.Render(instructionalButton)
    if RageUIJob.CurrentMenu ~= nil then
        if RageUIJob.CurrentMenu() then
            if RageUIJob.CurrentMenu.Safezone then
                ResetScriptGfxAlign()
            end
            if (instructionalButton) then
                DrawScaleformMovieFullscreen(RageUIJob.CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
            end
            RageUIJob.CurrentMenu.Options = RageUIJob.Options
            RageUIJob.CurrentMenu.SafeZoneSize = nil
            RageUIJob.Controls()
            RageUIJob.Options = 0
            RageUIJob.StatisticPanelCount = 0
            RageUIJob.ItemOffset = 0
            if RageUIJob.CurrentMenu.Controls.Back.Enabled and RageUIJob.CurrentMenu.Closable then
                if RageUIJob.CurrentMenu.Controls.Back.Pressed then
                    RageUIJob.CurrentMenu.Controls.Back.Pressed = false
                    local Audio = RageUIJob.Settings.Audio
                    RageUIJob.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
                    collectgarbage()
                    if RageUIJob.CurrentMenu.Closed ~= nil then
                        RageUIJob.CurrentMenu.Closed()
                    end
                    if RageUIJob.CurrentMenu.Parent ~= nil then
                        if RageUIJob.CurrentMenu.Parent() then
                            RageUIJob.NextMenu = RageUIJob.CurrentMenu.Parent
                            RageUIJob.CurrentMenu:UpdateCursorStyle()
                        else
                            --print('xxx') Debug print
                            RageUIJob.NextMenu = nil
                            RageUIJob.Visible(RageUIJob.CurrentMenu, false)
                        end
                    else
                        --print('zz') Debug print
                        RageUIJob.NextMenu = nil
                        RageUIJob.Visible(RageUIJob.CurrentMenu, false)
                    end
                end
            end
            if RageUIJob.NextMenu ~= nil then
                if RageUIJob.NextMenu() then
                    RageUIJob.Visible(RageUIJob.CurrentMenu, false)
                    RageUIJob.Visible(RageUIJob.NextMenu, true)
                    RageUIJob.CurrentMenu.Controls.Select.Active = false
                    RageUIJob.NextMenu = nil
                    RageUIJob.LastControl = false
                end
            end
        end
    end
end

---ItemsDescription
---@param CurrentMenu table
---@param Description string
---@param Selected boolean
---@return nil
---@public
function RageUIJob.ItemsDescription(CurrentMenu, Description, Selected)
    ---@type table
    if Description ~= "" or Description ~= nil then
        local SettingsDescription = RageUIJob.Settings.Items.Description;
        if Selected and CurrentMenu.Description ~= Description then
            CurrentMenu.Description = Description or nil
            ---@type number
            local DescriptionLineCount = GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + RageUIJob.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + (CurrentMenu.WidthOffset - 5.0))
            if DescriptionLineCount > 1 then
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount
            else
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 7
            end
        end
    end
end

---MouseBounds
---@param CurrentMenu table
---@param Selected boolean
---@param Option number
---@param SettingsButton table
---@return boolean
---@public
function RageUIJob.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
    ---@type boolean
    local Hovered = false
    Hovered = RageUIJob.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUIJob.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)
    if Hovered and not Selected then
        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + RageUIJob.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option
            local Audio = RageUIJob.Settings.Audio
            RageUIJob.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
        end
    end
    return Hovered;
end

---ItemsSafeZone
---@param CurrentMenu table
---@return nil
---@public
function RageUIJob.ItemsSafeZone(CurrentMenu)
    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = RageUIJob.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end
end

function RageUIJob.CurrentIsEqualTo(Current, To, Style, DefaultStyle)
    if (Current == To) then
        return Style;
    else
        return DefaultStyle or {};
    end
end

function RageUIJob.RefreshPagination()
    if (RageUIJob.CurrentMenu ~= nil) then
        if (RageUIJob.CurrentMenu.Index > 10) then
            local offset = RageUIJob.CurrentMenu.Index - 10
            RageUIJob.CurrentMenu.Pagination.Minimum = 1 + offset
            RageUIJob.CurrentMenu.Pagination.Maximum = 10 + offset
        else
            RageUIJob.CurrentMenu.Pagination.Minimum = 1
            RageUIJob.CurrentMenu.Pagination.Maximum = 10
        end
    end
end

function RageUIJob.IsVisible(menu, header, glare, instructional, items, panels)
    if (RageUIJob.Visible(menu)) then
        if (header == true) then
            RageUIJob.Banner(true, glare or false)
        end
        RageUIJob.Subtitle()
        if (items ~= nil) then
            items()
        end
        RageUIJob.Background();
        RageUIJob.Navigation();
        RageUIJob.Description();
        if (panels ~= nil) then
            panels()
        end
        RageUIJob.Render(instructional or false)
    end
end


---CreateWhile
---@param wait number
---@param menu table
---@param key number
---@param closure function
---@return void
---@public
function RageUIJob.CreateWhile(wait, menu, key, closure)
    Citizen.CreateThread(function()
        while (true) do
            Citizen.Wait(wait or 0.1)

            if (key ~= nil) then
                if IsControlJustPressed(1, key) then
                    RageUIJob.Visible(menu, not RageUIJob.Visible(menu))
                end
            end

            closure()
        end
    end)
end

---SetStyleAudio
---@param StyleAudio string
---@return void
---@public
function RageUIJob.SetStyleAudio(StyleAudio)
    RageUIJob.Settings.Audio.Use = StyleAudio or "RageUI"
end

function RageUIJob.GetStyleAudio()
    return RageUIJob.Settings.Audio.Use or "RageUI"
end

