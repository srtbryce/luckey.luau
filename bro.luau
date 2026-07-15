local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Name = "discord.gg/NVhQt7JSqV"
local gradienttype = "phantom"
local ImageId = 15602019048
local BackgroundColor = Color3.fromRGB(255, 255, 255)
local LOAD_SCREEN_TIME = 4

local function Tween(obj, duration, props, style, direction)
	if not obj or not obj.Parent then
		return nil
	end

	local tween = TweenService:Create(
		obj,
		TweenInfo.new(
			duration or 0.5,
			style or Enum.EasingStyle.Quint,
			direction or Enum.EasingDirection.Out
		),
		props
	)

	tween:Play()
	return tween
end

local function Notify(text, pos)
	task.spawn(function()
		local success, err = pcall(function()
			local controllers = ReplicatedStorage:WaitForChild("Controllers", 10)
			if not controllers then
				return
			end

			local controllerModule = controllers:WaitForChild(
				"NotificationController",
				10
			)

			if not controllerModule then
				return
			end

			local NotificationController = require(controllerModule)

			NotificationController:Notify(
				text,
				1231683126832612,
				nil,
				pos
			)
		end)

		if not success then
			warn("Notification error:", err)
		end
	end)
end

local oldScreen = PlayerGui:FindFirstChild("LuckeyLoadingScreen")
if oldScreen then
	oldScreen:Destroy()
end

local Screen = Instance.new("ScreenGui")
Screen.Name = "LuckeyLoadingScreen"
Screen.IgnoreGuiInset = true
Screen.ResetOnSpawn = false
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Global
Screen.DisplayOrder = 999999
Screen.Parent = PlayerGui

local Black = Instance.new("Frame")
Black.Name = "Background"
Black.Size = UDim2.fromScale(1, 1)
Black.Position = UDim2.fromScale(0, 0)
Black.BackgroundColor3 = Color3.new(0, 0, 0)
Black.BackgroundTransparency = 0
Black.BorderSizePixel = 0
Black.ZIndex = 1
Black.Parent = Screen

local Icon = Instance.new("ImageLabel")
Icon.Name = "Icon"
Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Icon.Position = UDim2.fromScale(0.5, 0.5)
Icon.Size = UDim2.fromOffset(750, 750)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://" .. tostring(ImageId)
Icon.ImageTransparency = 1
Icon.ScaleType = Enum.ScaleType.Fit
Icon.ZIndex = 10
Icon.Parent = Black

local CountLabel = Instance.new("TextLabel")
CountLabel.Name = "CreatorLabel"
CountLabel.AnchorPoint = Vector2.new(0.5, 0.5)
CountLabel.Position = UDim2.new(0.5, 0, 0.5, 130)
CountLabel.Size = UDim2.fromOffset(420, 30)
CountLabel.BackgroundTransparency = 1
CountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CountLabel.TextTransparency = 1
CountLabel.Font = Enum.Font.GothamMedium
CountLabel.TextSize = 14
CountLabel.Text = "@luataun"
CountLabel.ZIndex = 11
CountLabel.Parent = Black

local Vignette = Instance.new("ImageLabel")
Vignette.Name = "Vignette"
Vignette.AnchorPoint = Vector2.new(0.5, 0.5)
Vignette.Position = UDim2.fromScale(0.5, 0.5)
Vignette.Size = UDim2.fromScale(1, 1)
Vignette.BackgroundTransparency = 1
Vignette.Image = "rbxassetid://18720640102"
Vignette.ImageColor3 = BackgroundColor
Vignette.ImageTransparency = 1
Vignette.ScaleType = Enum.ScaleType.Stretch
Vignette.ZIndex = 5
Vignette.Parent = Black

local StartupSound = Instance.new("Sound")
StartupSound.Name = "LuckeyStartupSound"
StartupSound.SoundId = "rbxassetid://6963676402"
StartupSound.Volume = 0.3
StartupSound.Parent = SoundService

-- Make sure Roblox renders the GUI before starting animations.
task.wait()

Tween(Black, 0.35, {
	BackgroundTransparency = 0.5
})

task.delay(0.35, function()
	pcall(function()
		StartupSound.TimePosition = 1
		StartupSound:Play()
	end)

	Tween(Icon, 0.45, {
		ImageTransparency = 0.01,
		Size = UDim2.fromOffset(200, 200)
	})

	Tween(CountLabel, 0.45, {
		TextTransparency = 0.3
	})

	task.delay(0.2, function()
		Tween(Vignette, 2, {
			ImageTransparency = 0.2
		})
	end)
end)

task.spawn(function()
	while not game:IsLoaded()
		and not ReplicatedFirst:GetAttribute("ClientLoaded") do
		task.wait(0.1)
	end

	Notify(
		string.format(
			"<%s>%s</%s>",
			gradienttype,
			Name,
			gradienttype
		),
		"Top"
	)
end)

task.wait(LOAD_SCREEN_TIME)

Tween(Vignette, 0.8, {
	ImageTransparency = 1,
	Size = UDim2.fromScale(2, 2)
})

Tween(Icon, 0.6, {
	ImageTransparency = 1
})

Tween(CountLabel, 0.4, {
	TextTransparency = 1
})

local fade = Tween(Black, 0.8, {
	BackgroundTransparency = 1
})

if fade then
	fade.Completed:Wait()
else
	task.wait(0.8)
end

if Screen.Parent then
	Screen:Destroy()
end

if StartupSound.Parent then
	StartupSound:Destroy()
end
