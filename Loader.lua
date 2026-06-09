local HttpGet = game.HttpGet
local GameId  = game.GameId

local Games = loadstring(
    HttpGet(game, "https://raw.githubusercontent.com/Tvenn16/QH/main/GameList.lua")
)() :: any

local URL = Games[GameId]

if not URL then
    local Players = game:GetService("Players")
    local player  = Players.LocalPlayer
    local pgui    = player:WaitForChild("PlayerGui")

    local sg = Instance.new("ScreenGui", pgui)
    sg.ResetOnSpawn  = false
    sg.DisplayOrder  = 999

    local frame = Instance.new("Frame", sg)
    frame.Size             = UDim2.new(0,320,0,80)
    frame.Position         = UDim2.new(0.5,-160,0,20)
    frame.BackgroundColor3 = Color3.fromRGB(10,14,10)
    frame.BorderSizePixel  = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color     = Color3.fromRGB(200,70,70)
    stroke.Thickness = 1.5

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size               = UDim2.new(1,-20,1,0)
    lbl.Position           = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text               = "🌿 BARF QH\nThis game is not supported yet."
    lbl.TextColor3         = Color3.fromRGB(210,255,210)
    lbl.TextSize           = 14
    lbl.Font               = Enum.Font.GothamBold
    lbl.TextXAlignment     = Enum.TextXAlignment.Center

    task.delay(4, function() sg:Destroy() end)
    return
end

loadstring(HttpGet(game, URL))()
