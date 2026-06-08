-- BARF QH Key System
-- Place this at the TOP of your script, before any other code.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ── CONFIG ───────────────────────────────────────────────────────────────
local KEY_API    = "https://script.google.com/macros/s/AKfycbwB9VnGnPdNHz8Fl0flOFC-AGa5y_YBTz7IH6_XR1yrXzoRf25tld9DIHwXsCgyvqB7hw/exec"
local LOADER_URL = "https://raw.githubusercontent.com/Tvenn16/QH/main/BARFQH.lua"
local LOOTLABS_URL = "https://lootdest.org/s?GfNWObxH"
local TITLE_TEXT = "BARF QH"
local SUBTITLE   = "Key System"
-- ─────────────────────────────────────────────────────────────────────────

-- ── THEME ─────────────────────────────────────────────────────────────────
local C = {
	bg         = Color3.fromRGB(10,  14,  10),
	titleBg    = Color3.fromRGB(20,  32,  20),
	border     = Color3.fromRGB(42,  90,  42),
	accent     = Color3.fromRGB(80,  200, 80),
	accentDim  = Color3.fromRGB(45,  110, 45),
	textBright = Color3.fromRGB(210, 255, 210),
	textMid    = Color3.fromRGB(130, 170, 130),
	textDim    = Color3.fromRGB(75,  100, 75),
	red        = Color3.fromRGB(200, 70,  70),
	redBg      = Color3.fromRGB(80,  22,  22),
	inputBg    = Color3.fromRGB(14,  20,  14),
	lootlabs   = Color3.fromRGB(255, 165, 0),
	lootlabsDim= Color3.fromRGB(180, 110, 0),
}
-- ─────────────────────────────────────────────────────────────────────────

local pgui = player:WaitForChild("PlayerGui")
if pgui:FindFirstChild("BARFQH_KeySystem") then
	pgui.BARFQH_KeySystem:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "BARFQH_KeySystem"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.DisplayOrder   = 200
ScreenGui.Parent         = pgui

-- ── DIMMER ────────────────────────────────────────────────────────────────
local Dimmer = Instance.new("Frame", ScreenGui)
Dimmer.Size                   = UDim2.new(1,0,1,0)
Dimmer.BackgroundColor3       = Color3.fromRGB(0,0,0)
Dimmer.BackgroundTransparency = 0.55
Dimmer.BorderSizePixel        = 0
Dimmer.ZIndex                 = 1

-- ── MAIN CARD ─────────────────────────────────────────────────────────────
local CARD_W, CARD_H = 360, 370
local Card = Instance.new("Frame", ScreenGui)
Card.Size                     = UDim2.new(0, CARD_W, 0, CARD_H)
Card.Position                 = UDim2.new(0.5, -CARD_W/2, 0.5, -CARD_H/2)
Card.BackgroundColor3         = C.bg
Card.BackgroundTransparency   = 0.30  -- 70% visible = 30% transparency
Card.BorderSizePixel          = 0
Card.ZIndex                   = 10
Card.ClipsDescendants         = false
Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 16)
local CardStroke = Instance.new("UIStroke", Card)
CardStroke.Color     = C.border
CardStroke.Thickness = 1.5

-- ── DRAGGING ──────────────────────────────────────────────────────────────
local dragging, dragStart, startPos = false, nil, nil

local function onDragStart(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging  = true
		dragStart = input.Position
		startPos  = Card.Position
	end
end

local function onDragUpdate(input)
	if dragging then
		local delta = input.Position - dragStart
		Card.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end

local function onDragEnd(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end

-- ── TITLE BAR ─────────────────────────────────────────────────────────────
local TitleBar = Instance.new("Frame", Card)
TitleBar.Size             = UDim2.new(1,0,0,40)
TitleBar.BackgroundColor3 = C.titleBg
TitleBar.BackgroundTransparency = 0.20
TitleBar.BorderSizePixel  = 0
TitleBar.ZIndex           = 11
TitleBar.Active           = true
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)

-- cover bottom round corners of titlebar
local TFill = Instance.new("Frame", TitleBar)
TFill.Size             = UDim2.new(1,0,0.5,0)
TFill.Position         = UDim2.new(0,0,0.5,0)
TFill.BackgroundColor3 = C.titleBg
TFill.BackgroundTransparency = 0.20
TFill.BorderSizePixel  = 0
TFill.ZIndex           = 10

-- Drag binds on title bar
TitleBar.InputBegan:Connect(onDragStart)
TitleBar.InputChanged:Connect(onDragUpdate)
TitleBar.InputEnded:Connect(onDragEnd)
UserInputService.InputChanged:Connect(function(input)
	if dragging then onDragUpdate(input) end
end)
UserInputService.InputEnded:Connect(onDragEnd)

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

-- ── CLOSE BUTTON ──────────────────────────────────────────────────────────
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size             = UDim2.new(0,22,0,22)
CloseBtn.Position         = UDim2.new(1,-28,0.5,-11)
CloseBtn.BackgroundColor3 = C.redBg
CloseBtn.Text             = "✕"
CloseBtn.TextColor3       = C.red
CloseBtn.TextSize         = 13
CloseBtn.Font             = Enum.Font.GothamBold
CloseBtn.AutoButtonColor  = false
CloseBtn.ZIndex           = 13
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

CloseBtn.MouseEnter:Connect(function()
	TweenService:Create(CloseBtn, TweenInfo.new(0.12),
		{BackgroundColor3=C.red, TextColor3=Color3.new(1,1,1)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
	TweenService:Create(CloseBtn, TweenInfo.new(0.12),
		{BackgroundColor3=C.redBg, TextColor3=C.red}):Play()
end)
CloseBtn.MouseButton1Click:Connect(function()
	TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Position = UDim2.new(0.5,-CARD_W/2,1.5,-CARD_H/2), BackgroundTransparency=1}):Play()
	TweenService:Create(Dimmer, TweenInfo.new(0.3), {BackgroundTransparency=1}):Play()
	task.delay(0.35, function() ScreenGui:Destroy() end)
end)

-- accent line
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

-- ── BODY ──────────────────────────────────────────────────────────────────
local LockIcon = Instance.new("TextLabel", Card)
LockIcon.Size               = UDim2.new(1,0,0,46)
LockIcon.Position           = UDim2.new(0,0,0,48)
LockIcon.BackgroundTransparency = 1
LockIcon.Text               = "🔒"
LockIcon.TextSize           = 30
LockIcon.Font               = Enum.Font.GothamBold
LockIcon.TextXAlignment     = Enum.TextXAlignment.Center
LockIcon.ZIndex             = 11

local InstLabel = Instance.new("TextLabel", Card)
InstLabel.Size               = UDim2.new(1,-40,0,20)
InstLabel.Position           = UDim2.new(0,20,0,96)
InstLabel.BackgroundTransparency = 1
InstLabel.Text               = "Enter your key to continue"
InstLabel.TextColor3         = C.textMid
InstLabel.TextSize           = 14
InstLabel.Font               = Enum.Font.Gotham
InstLabel.TextXAlignment     = Enum.TextXAlignment.Center
InstLabel.ZIndex             = 11

-- Key input
local InputBox = Instance.new("TextBox", Card)
InputBox.Size                = UDim2.new(1,-40,0,36)
InputBox.Position            = UDim2.new(0,20,0,122)
InputBox.BackgroundColor3    = C.inputBg
InputBox.BackgroundTransparency = 0.20
InputBox.BorderSizePixel     = 0
InputBox.Text                = ""
InputBox.PlaceholderText     = "Paste key here..."
InputBox.PlaceholderColor3   = C.textDim
InputBox.TextColor3          = C.textBright
InputBox.TextSize            = 14
InputBox.Font                = Enum.Font.Gotham
InputBox.ClearTextOnFocus    = false
InputBox.ZIndex              = 12
Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 10)
local InputStroke = Instance.new("UIStroke", InputBox)
InputStroke.Color     = C.border
InputStroke.Thickness = 1
local InputPad = Instance.new("UIPadding", InputBox)
InputPad.PaddingLeft  = UDim.new(0,10)
InputPad.PaddingRight = UDim.new(0,10)

-- Status label
local StatusLabel = Instance.new("TextLabel", Card)
StatusLabel.Size               = UDim2.new(1,-40,0,18)
StatusLabel.Position           = UDim2.new(0,20,0,163)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text               = ""
StatusLabel.TextColor3         = C.red
StatusLabel.TextSize           = 13
StatusLabel.Font               = Enum.Font.Gotham
StatusLabel.TextXAlignment     = Enum.TextXAlignment.Center
StatusLabel.ZIndex             = 11

-- Unlock button
local SubmitBtn = Instance.new("TextButton", Card)
SubmitBtn.Size              = UDim2.new(1,-40,0,36)
SubmitBtn.Position          = UDim2.new(0,20,0,186)
SubmitBtn.BackgroundColor3  = C.accentDim
SubmitBtn.BorderSizePixel   = 0
SubmitBtn.Text              = "🔓  Unlock"
SubmitBtn.TextColor3        = C.textBright
SubmitBtn.TextSize          = 15
SubmitBtn.Font              = Enum.Font.GothamBold
SubmitBtn.AutoButtonColor   = false
SubmitBtn.ZIndex            = 12
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", SubmitBtn).Color = C.border

SubmitBtn.MouseEnter:Connect(function()
	TweenService:Create(SubmitBtn, TweenInfo.new(0.12), {BackgroundColor3=C.accent}):Play()
end)
SubmitBtn.MouseLeave:Connect(function()
	TweenService:Create(SubmitBtn, TweenInfo.new(0.12), {BackgroundColor3=C.accentDim}):Play()
end)

-- ── LOOTLABS BUTTON ───────────────────────────────────────────────────────
local LootBtn = Instance.new("TextButton", Card)
LootBtn.Size              = UDim2.new(1,-40,0,36)
LootBtn.Position          = UDim2.new(0,20,0,230)
LootBtn.BackgroundColor3  = C.lootlabsDim
LootBtn.BorderSizePixel   = 0
LootBtn.Text              = "🔑  Get Key  (Lootlabs)"
LootBtn.TextColor3        = Color3.fromRGB(255, 220, 150)
LootBtn.TextSize          = 14
LootBtn.Font              = Enum.Font.GothamBold
LootBtn.AutoButtonColor   = false
LootBtn.ZIndex            = 12
Instance.new("UICorner", LootBtn).CornerRadius = UDim.new(0, 10)
local LootStroke = Instance.new("UIStroke", LootBtn)
LootStroke.Color     = Color3.fromRGB(200,130,0)
LootStroke.Thickness = 1

LootBtn.MouseEnter:Connect(function()
	TweenService:Create(LootBtn, TweenInfo.new(0.12), {BackgroundColor3=C.lootlabs}):Play()
end)
LootBtn.MouseLeave:Connect(function()
	TweenService:Create(LootBtn, TweenInfo.new(0.12), {BackgroundColor3=C.lootlabsDim}):Play()
end)
LootBtn.MouseButton1Click:Connect(function()
	pcall(function() setclipboard(LOOTLABS_URL) end)
	local orig = LootBtn.Text
	LootBtn.Text = "✔  Link copied to clipboard!"
	task.delay(2, function() LootBtn.Text = orig end)
end)

-- hint
local HintLabel = Instance.new("TextLabel", Card)
HintLabel.Size               = UDim2.new(1,-40,0,16)
HintLabel.Position           = UDim2.new(0,20,0,272)
HintLabel.BackgroundTransparency = 1
HintLabel.Text               = "Complete the offer to receive your key"
HintLabel.TextColor3         = C.textDim
HintLabel.TextSize           = 11
HintLabel.Font               = Enum.Font.Gotham
HintLabel.TextXAlignment     = Enum.TextXAlignment.Center
HintLabel.ZIndex             = 11

-- ── RESET SECTION ─────────────────────────────────────────────────────────
local ResetDivider = Instance.new("Frame", Card)
ResetDivider.Size             = UDim2.new(1,-40,0,1)
ResetDivider.Position         = UDim2.new(0,20,0,296)
ResetDivider.BackgroundColor3 = C.border
ResetDivider.BorderSizePixel  = 0
ResetDivider.ZIndex           = 11

local ResetBox = Instance.new("TextBox", Card)
ResetBox.Size             = UDim2.new(0,196,0,30)
ResetBox.Position         = UDim2.new(0,20,0,306)
ResetBox.BackgroundColor3 = C.inputBg
ResetBox.BackgroundTransparency = 0.20
ResetBox.BorderSizePixel  = 0
ResetBox.Text             = ""
ResetBox.PlaceholderText  = "Reset code..."
ResetBox.PlaceholderColor3= C.textDim
ResetBox.TextColor3       = C.textBright
ResetBox.TextSize         = 13
ResetBox.Font             = Enum.Font.Gotham
ResetBox.ClearTextOnFocus = false
ResetBox.ZIndex           = 12
Instance.new("UICorner", ResetBox).CornerRadius = UDim.new(0, 10)
local ResetStroke = Instance.new("UIStroke", ResetBox)
ResetStroke.Color = C.border
local RP = Instance.new("UIPadding", ResetBox)
RP.PaddingLeft = UDim.new(0,8)

local ResetBtn = Instance.new("TextButton", Card)
ResetBtn.Size             = UDim2.new(0,116,0,30)
ResetBtn.Position         = UDim2.new(0,224,0,306)
ResetBtn.BackgroundColor3 = Color3.fromRGB(30,50,70)
ResetBtn.BorderSizePixel  = 0
ResetBtn.Text             = "Reset HWID"
ResetBtn.TextColor3       = Color3.fromRGB(150,200,255)
ResetBtn.TextSize         = 13
ResetBtn.Font             = Enum.Font.GothamBold
ResetBtn.AutoButtonColor  = false
ResetBtn.ZIndex           = 12
Instance.new("UICorner", ResetBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", ResetBtn).Color = Color3.fromRGB(60,100,140)

ResetBtn.MouseEnter:Connect(function()
	TweenService:Create(ResetBtn, TweenInfo.new(0.12),
		{BackgroundColor3=Color3.fromRGB(50,80,110)}):Play()
end)
ResetBtn.MouseLeave:Connect(function()
	TweenService:Create(ResetBtn, TweenInfo.new(0.12),
		{BackgroundColor3=Color3.fromRGB(30,50,70)}):Play()
end)

-- ── FOCUS GLOW ────────────────────────────────────────────────────────────
InputBox.Focused:Connect(function()
	TweenService:Create(InputStroke, TweenInfo.new(0.15), {Color=C.accent, Thickness=1.5}):Play()
end)
InputBox.FocusLost:Connect(function()
	TweenService:Create(InputStroke, TweenInfo.new(0.15), {Color=C.border, Thickness=1}):Play()
end)
ResetBox.Focused:Connect(function()
	TweenService:Create(ResetStroke, TweenInfo.new(0.15), {Color=Color3.fromRGB(100,160,220), Thickness=1.5}):Play()
end)
ResetBox.FocusLost:Connect(function()
	TweenService:Create(ResetStroke, TweenInfo.new(0.15), {Color=C.border, Thickness=1}):Play()
end)

-- ── STATUS HELPER ─────────────────────────────────────────────────────────
local function setStatus(msg, isError)
	StatusLabel.Text       = msg
	StatusLabel.TextColor3 = isError and C.red or C.accent
end

local function shakeCard()
	local orig = Card.Position
	for _, offset in ipairs({8,-8,6,-6,3,-3,0}) do
		TweenService:Create(Card, TweenInfo.new(0.04),
			{Position = UDim2.new(orig.X.Scale, orig.X.Offset+offset, orig.Y.Scale, orig.Y.Offset)}):Play()
		task.wait(0.04)
	end
	Card.Position = orig
end

-- ── UNLOCK LOGIC ──────────────────────────────────────────────────────────
local function onSubmit()
	local entered = InputBox.Text:match("^%s*(.-)%s*$")
	if entered == "" then
		setStatus("⚠  Please enter a key.", true)
		return
	end

	setStatus("⏳  Validating key...", false)
	SubmitBtn.Active = false

	task.spawn(function()
		local url = KEY_API .. "?action=validate&key=" .. entered .. "&user=" .. player.Name
		local ok, result = pcall(function() return game:HttpGet(url) end)

		if not ok then
			setStatus("✘  Network error. Try again.", true)
			SubmitBtn.Active = true
			return
		end

		result = result:match("^%s*(.-)%s*$")

		if result == "OK" then
			setStatus("✔  Key accepted! Loading...", false)
			LockIcon.Text    = "🔓"
			SubmitBtn.Active = false
			LootBtn.Active   = false
			TweenService:Create(Card, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				{Position = UDim2.new(0.5,-CARD_W/2,1.5,-CARD_H/2), BackgroundTransparency=1}):Play()
			TweenService:Create(Dimmer, TweenInfo.new(0.5), {BackgroundTransparency=1}):Play()
			task.delay(0.5, function()
				ScreenGui:Destroy()
				loadstring(game:HttpGet(LOADER_URL))()
			end)
		elseif result == "TAKEN" then
			setStatus("✘  Key already used by another user.", true)
			SubmitBtn.Active = true
			shakeCard()
		else
			setStatus("✘  Invalid key. Try again.", true)
			SubmitBtn.Active = true
			shakeCard()
			TweenService:Create(InputStroke, TweenInfo.new(0.1), {Color=C.red}):Play()
			task.delay(0.6, function()
				TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color=C.border}):Play()
			end)
		end
	end)
end

-- ── RESET LOGIC ───────────────────────────────────────────────────────────
ResetBtn.MouseButton1Click:Connect(function()
	local code = ResetBox.Text:match("^%s*(.-)%s*$")
	if code == "" then
		setStatus("⚠  Enter your reset code.", true)
		return
	end
	setStatus("⏳  Resetting HWID...", false)
	ResetBtn.Active = false
	task.spawn(function()
		local url = KEY_API .. "?action=reset&resetcode=" .. code .. "&user=" .. player.Name
		local ok, result = pcall(function() return game:HttpGet(url) end)
		if not ok then
			setStatus("✘  Network error.", true)
			ResetBtn.Active = true
			return
		end
		result = result:match("^%s*(.-)%s*$")
		if result == "RESET_OK" then
			setStatus("✔  HWID reset! Re-enter your key.", false)
			ResetBox.Text = ""
		elseif result == "RESET_USED" then
			setStatus("✘  Reset code already used.", true)
		else
			setStatus("✘  Invalid reset code.", true)
		end
		ResetBtn.Active = true
	end)
end)

SubmitBtn.MouseButton1Click:Connect(onSubmit)
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
		onSubmit()
	end
end)

-- ── ENTRY ANIMATION ───────────────────────────────────────────────────────
Card.Position = UDim2.new(0.5,-CARD_W/2, 1.5,-CARD_H/2)
TweenService:Create(Card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	{Position = UDim2.new(0.5,-CARD_W/2, 0.5,-CARD_H/2)}):Play()
