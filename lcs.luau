
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local Name = "discord.gg/NVhQt7JSqV"
local gradienttype = "phantom"
local ImageId = 15602019048
local BackgroundColor = Color3.fromRGB(255, 255, 255)
local LOAD_SCREEN_TIME = 4

local function Tween(obj, time, props, style, dir)
	local t = TweenService:Create(
		obj,
		TweenInfo.new(time or 0.5, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out),
		props
	)
	t:Play()
	return t
end

local function Notify(text, pos)
	pcall(function()
		local controller = ReplicatedStorage
			:WaitForChild("Controllers", 10)
			:WaitForChild("NotificationController", 10)

		local NotificationController = require(controller)
		NotificationController:Notify(text, 1231683126832612, nil, pos)
	end)
end

local Screen = Instance.new("ScreenGui")
Screen.Name = "LuckeyLoadingScreen"
Screen.IgnoreGuiInset = true
Screen.ResetOnSpawn = false
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Global
Screen.DisplayOrder = 999999
Screen.Parent = PlayerGui

local Black = Instance.new("Frame")
Black.Size = UDim2.fromScale(1, 1)
Black.BackgroundColor3 = Color3.new(0, 0, 0)
Black.BorderSizePixel = 0
Black.Parent = Screen

local Icon = Instance.new("ImageLabel")
Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Icon.Position = UDim2.fromScale(0.5, 0.5)
Icon.Size = UDim2.fromOffset(750, 750)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://" .. ImageId
Icon.ImageTransparency = 1
Icon.ZIndex = 10
Icon.Parent = Black

local CountLabel = Instance.new("TextLabel")
CountLabel.AnchorPoint = Vector2.new(0.5, 0.5)
CountLabel.Position = UDim2.new(0.5, 0, 0.5, 130)
CountLabel.Size = UDim2.fromOffset(420, 30)
CountLabel.BackgroundTransparency = 1
CountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CountLabel.TextTransparency = 0.3
CountLabel.Font = Enum.Font.GothamMedium
CountLabel.TextSize = 14
CountLabel.Text = "@luataun"
CountLabel.ZIndex = 11
CountLabel.Parent = Black

local Vignette = Instance.new("ImageLabel")
Vignette.Size = UDim2.fromScale(1, 1)
Vignette.AnchorPoint = Vector2.new(0.5, 0.5)
Vignette.Position = UDim2.fromScale(0.5, 0.5)
Vignette.BackgroundTransparency = 1
Vignette.Image = "rbxassetid://18720640102"
Vignette.ImageColor3 = BackgroundColor
Vignette.ImageTransparency = 1
Vignette.Parent = Black

local StartupSound = Instance.new("Sound")
StartupSound.SoundId = "rbxassetid://6963676402"
StartupSound.Volume = 0.3
StartupSound.TimePosition = 1
StartupSound.Parent = SoundService

Tween(Black, 0.35, {BackgroundTransparency = 0.5})

task.delay(0.35, function()
	pcall(function()
		StartupSound:Play()
	end)

	Tween(Icon, 0.45, {
		ImageTransparency = 0.01,
		Size = UDim2.fromOffset(200, 200)
	})

	task.delay(0.2, function()
		Tween(Vignette, 2, {
			ImageTransparency = 0.2
		})
	end)
end)

task.spawn(function()
	repeat task.wait(0.1) until ReplicatedFirst:GetAttribute("ClientLoaded") or game:IsLoaded()


	Notify(string.format("<%s>%s</%s>", gradienttype, Name, gradienttype), "Top")
	task.wait(0.35)
	--Notify(string.format("<%s>Loaded in %.2fs</%s>", "og", gameLoadTime, "og"))
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

fade.Completed:Wait()

Screen:Destroy()
StartupSound:Destroy()
