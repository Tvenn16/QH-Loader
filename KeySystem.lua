local LOADER_URL = "https://raw.githubusercontent.com/YourUsername/QH-Loader/main/BARFQH.lua"

-- BARF QH Key System
-- Place this at the TOP of your script, before any other code.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ── CONFIG ──────────────────────────────────────────────────────────────
local VALID_KEY   = "BARF-QH-2025"          -- change to your real key
local LOADER_URL  = "https://raw.githubusercontent.com/Tvenn16/QH/main/BARFQH.lua"
local TITLE_TEXT  = "BARF QH"
local SUBTITLE    = "Key System"
-- ────────────────────────────────────────────────────────────────────────

-- ── THEME (mirrors your main script's C table) ──────────────────────────
local C = {
	bg         = Color3.fromRGB(10,  14,  10),
	sidebar    = Color3.fromRGB(13,  20,  13),
	panel      = Color3.fromRGB(16,  22,  16),
	titleBg    = Color3.fromRGB(20,  32,  20),
	border     = Color3.fromRGB(42,  90,  42),
	accent     = Color3.fromRGB(80,  200, 80),
	accentDim  = Color3.fromRGB(45,  110, 45),
	textBright = Color3.fromRGB(210, 255, 210),
	textMid    = Color3.fromRGB(130, 170, 130),
	textDim    = Color3.fromRGB(75,  100, 75),
	red        = Color3.fromRGB(200, 70,  70),
	redBg      = Color3.fromRGB(80,  22,  22),
	toggleOff  = Color3.fromRGB(18,  28,  18),
	inputBg    = Color3.fromRGB(14,  20,  14),
	divider    = Color3.fromRGB(30,  48,  30),
}
-- ────────────────────────────────────────────────────────────────────────

-- Destroy any leftover GUI
local pgui = player:WaitForChild("PlayerGui")
if pgui:FindFirstChild("BARFQH_KeySystem") then
	pgui.BARFQH_KeySystem:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name            = "BARFQH_KeySystem"
ScreenGui.ResetOnSpawn    = false
ScreenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Global
ScreenGui.DisplayOrder    = 200
ScreenGui.Parent          = pgui

-- ── BLUR / DIMMER ────────────────────────────────────────────────────────
local Dimmer = Instance.new("Frame", ScreenGui)
Dimmer.Size                = UDim2.new(1,0,1,0)
Dimmer.BackgroundColor3    = Color3.fromRGB(0,0,0)
Dimmer.BackgroundTransparency = 0.45
Dimmer.BorderSizePixel     = 0
Dimmer.ZIndex              = 1

-- ── MAIN CARD ────────────────────────────────────────────────────────────
local Card = Instance.new("Frame", ScreenGui)
Card.Size              = UDim2.new(0, 360, 0, 300)
Card.Position          = UDim2.new(0.5, -180, 0.5, -150)
Card.BackgroundColor3  = C.bg
Card.BorderSizePixel   = 0
Card.ZIndex            = 10
Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 12)
local CardStroke = Instance.new("UIStroke", Card)
CardStroke.Color     = C.border
CardStroke.Thickness = 1.5

-- ── TITLE BAR ────────────────────────────────────────────────────────────
local TitleBar = Instance.new("Frame", Card)
TitleBar.Size             = UDim2.new(1,0,0,40)
TitleBar.BackgroundColor3 = C.titleBg
TitleBar.BorderSizePixel  = 0
TitleBar.ZIndex           = 11
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)
-- cover bottom corners
local TFill = Instance.new("Frame", TitleBar)
TFill.Size             = UDim2.new(1,0,0.5,0)
TFill.Position         = UDim2.new(0,0,0.5,0)
TFill.BackgroundColor3 = C.titleBg
TFill.BorderSizePixel  = 0
TFill.ZIndex           = 10

local TIcon = Instance.new("TextLabel", TitleBar)
TIcon.Size               = UDim2.new(0,30,1,0)
TIcon.Position           = UDim2.new(0,10,0,0)
TIcon.BackgroundTransparency = 1
TIcon.Text               = "🌿"
TIcon.TextSize           = 17
TIcon.Font               = Enum.Font.GothamBold
TIcon.ZIndex             = 12

local TLabel = Instance.new("TextLabel", TitleBar)
TLabel.Size               = UDim2.new(1,-80,1,0)
TLabel.Position           = UDim2.new(0,42,0,0)
TLabel.BackgroundTransparency = 1
TLabel.Text               = TITLE_TEXT .. "  —  " .. SUBTITLE
TLabel.TextColor3         = C.textBright
TLabel.TextSize           = 15
TLabel.Font               = Enum.Font.GothamBold
TLabel.TextXAlignment     = Enum.TextXAlignment.Left
TLabel.ZIndex             = 12

-- accent line under title bar
local TLine = Instance.new("Frame", Card)
TLine.Size             = UDim2.new(1,-16,0,1)
TLine.Position         = UDim2.new(0,8,0,40)
TLine.BackgroundColor3 = C.accentDim
TLine.BorderSizePixel  = 0
TLine.ZIndex           = 11
local TLineGrad = Instance.new("UIGradient", TLine)
TLineGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,   C.accent),
	ColorSequenceKeypoint.new(0.5, C.accentDim),
	ColorSequenceKeypoint.new(1,   C.bg),
})

-- ── BODY ─────────────────────────────────────────────────────────────────
-- Lock icon area
local LockIcon = Instance.new("TextLabel", Card)
LockIcon.Size               = UDim2.new(1,0,0,48)
LockIcon.Position           = UDim2.new(0,0,0,50)
LockIcon.BackgroundTransparency = 1
LockIcon.Text               = "🔒"
LockIcon.TextSize           = 32
LockIcon.Font               = Enum.Font.GothamBold
LockIcon.TextXAlignment     = Enum.TextXAlignment.Center
LockIcon.ZIndex             = 11

-- Instruction label
local InstLabel = Instance.new("TextLabel", Card)
InstLabel.Size               = UDim2.new(1,-40,0,20)
InstLabel.Position           = UDim2.new(0,20,0,100)
InstLabel.BackgroundTransparency = 1
InstLabel.Text               = "Enter your key to continue"
InstLabel.TextColor3         = C.textMid
InstLabel.TextSize           = 14
InstLabel.Font               = Enum.Font.Gotham
InstLabel.TextXAlignment     = Enum.TextXAlignment.Center
InstLabel.ZIndex             = 11

-- Key input box
local InputBox = Instance.new("TextBox", Card)
InputBox.Size                = UDim2.new(1,-40,0,36)
InputBox.Position            = UDim2.new(0,20,0,128)
InputBox.BackgroundColor3    = C.inputBg
InputBox.BorderSizePixel     = 0
InputBox.Text                = ""
InputBox.PlaceholderText     = "Paste key here..."
InputBox.PlaceholderColor3   = C.textDim
InputBox.TextColor3          = C.textBright
InputBox.TextSize            = 14
InputBox.Font                = Enum.Font.Gotham
InputBox.ClearTextOnFocus    = false
InputBox.ZIndex              = 12
Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 8)
local InputStroke = Instance.new("UIStroke", InputBox)
InputStroke.Color     = C.border
InputStroke.Thickness = 1

local InputPad = Instance.new("UIPadding", InputBox)
InputPad.PaddingLeft  = UDim.new(0,10)
InputPad.PaddingRight = UDim.new(0,10)

-- Status label (hidden initially)
local StatusLabel = Instance.new("TextLabel", Card)
StatusLabel.Size               = UDim2.new(1,-40,0,18)
StatusLabel.Position           = UDim2.new(0,20,0,170)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text               = ""
StatusLabel.TextColor3         = C.red
StatusLabel.TextSize           = 13
StatusLabel.Font               = Enum.Font.Gotham
StatusLabel.TextXAlignment     = Enum.TextXAlignment.Center
StatusLabel.ZIndex             = 11

-- Submit button
local SubmitBtn = Instance.new("TextButton", Card)
SubmitBtn.Size              = UDim2.new(1,-40,0,38)
SubmitBtn.Position          = UDim2.new(0,20,0,196)
SubmitBtn.BackgroundColor3  = C.accentDim
SubmitBtn.BorderSizePixel   = 0
SubmitBtn.Text              = "Unlock"
SubmitBtn.TextColor3        = C.textBright
SubmitBtn.TextSize          = 15
SubmitBtn.Font              = Enum.Font.GothamBold
SubmitBtn.AutoButtonColor   = false
SubmitBtn.ZIndex            = 12
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)
local SubmitStroke = Instance.new("UIStroke", SubmitBtn)
SubmitStroke.Color     = C.border
SubmitStroke.Thickness = 1

-- Submit button hover
SubmitBtn.MouseEnter:Connect(function()
	TweenService:Create(SubmitBtn, TweenInfo.new(0.12), {BackgroundColor3=C.accent}):Play()
end)
SubmitBtn.MouseLeave:Connect(function()
	TweenService:Create(SubmitBtn, TweenInfo.new(0.12), {BackgroundColor3=C.accentDim}):Play()
end)

-- Get Key label / link hint
local GetKeyLabel = Instance.new("TextLabel", Card)
GetKeyLabel.Size               = UDim2.new(1,-40,0,16)
GetKeyLabel.Position           = UDim2.new(0,20,0,244)
GetKeyLabel.BackgroundTransparency = 1
GetKeyLabel.Text               = "Get your key in our Discord"
GetKeyLabel.TextColor3         = C.textDim
GetKeyLabel.TextSize           = 12
GetKeyLabel.Font               = Enum.Font.Gotham
GetKeyLabel.TextXAlignment     = Enum.TextXAlignment.Center
GetKeyLabel.ZIndex             = 11

-- ── INPUT FOCUS GLOW ─────────────────────────────────────────────────────
InputBox.Focused:Connect(function()
	TweenService:Create(InputStroke, TweenInfo.new(0.15), {Color=C.accent, Thickness=1.5}):Play()
end)
InputBox.FocusLost:Connect(function()
	TweenService:Create(InputStroke, TweenInfo.new(0.15), {Color=C.border, Thickness=1}):Play()
end)

-- ── UNLOCK LOGIC ─────────────────────────────────────────────────────────
local function setStatus(msg, isError)
	StatusLabel.Text       = msg
	StatusLabel.TextColor3 = isError and C.red or C.accent
end

local function onSubmit()
	local entered = InputBox.Text:match("^%s*(.-)%s*$") -- trim whitespace
	if entered == "" then
		setStatus("⚠ Please enter a key.", true)
		return
	end

	if entered == VALID_KEY then
		-- ✅ Correct key
		setStatus("✔ Key accepted! Loading...", false)
		LockIcon.Text = "🔓"
		SubmitBtn.Active = false

		-- Tween card out
		TweenService:Create(Card, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			{Position = UDim2.new(0.5,-180,1.5,-150), BackgroundTransparency=0.6}):Play()
		TweenService:Create(Dimmer, TweenInfo.new(0.5), {BackgroundTransparency=1}):Play()

		task.delay(0.5, function()
			ScreenGui:Destroy()
			-- ✅ Load the main script
			loadstring(game:HttpGet(LOADER_URL))()
		end)
	else
		-- ❌ Wrong key
		setStatus("✘ Invalid key. Try again.", true)
		-- Shake animation
		local orig = Card.Position
		local shakeOffsets = {8, -8, 6, -6, 3, -3, 0}
		for _, offset in ipairs(shakeOffsets) do
			TweenService:Create(Card, TweenInfo.new(0.04),
				{Position = UDim2.new(0.5, -180+offset, 0.5, -150)}):Play()
			task.wait(0.04)
		end
		Card.Position = orig
		-- Flash input red
		TweenService:Create(InputStroke, TweenInfo.new(0.1), {Color=C.red}):Play()
		task.delay(0.6, function()
			TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color=C.border}):Play()
		end)
	end
end

SubmitBtn.MouseButton1Click:Connect(onSubmit)
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
		onSubmit()
	end
end)

-- ── ENTRY ANIMATION ──────────────────────────────────────────────────────
Card.Position = UDim2.new(0.5,-180,1.5,-150)
TweenService:Create(Card, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	{Position = UDim2.new(0.5,-180,0.5,-150)}):Play()
