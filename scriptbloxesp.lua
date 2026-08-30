--========================================================--
--                 SCRIPTBLOX ESP                         --
--                  Made by Scriptblox                     --
--========================================================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--========================================================--
-- SETTINGS
--========================================================--

local Settings = {
	Enabled = true,
	Names = true,
	Distance = true,
	Health = true,
	Highlights = true,
	Boxes = true,
	Tracers = true,
	TeamCheck = false,

	Color = Color3.fromRGB(255, 45, 55),
	MaxDistance = 1000
}

local ESPObjects = {}

--========================================================--
-- GUI
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "ScriptbloxESP"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main window
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(350, 520)
Main.Position = UDim2.new(0, 30, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
Main.BorderSizePixel = 0
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 60, 72)
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

--========================================================--
-- GUI ANIMATION ADDITIONS
--========================================================--

local OriginalMainSize = Main.Size
local OriginalMainPosition = Main.Position

Main.Size = UDim2.fromOffset(320, 470)
Main.Position = UDim2.new(
	OriginalMainPosition.X.Scale,
	OriginalMainPosition.X.Offset,
	OriginalMainPosition.Y.Scale,
	OriginalMainPosition.Y.Offset + 25
)

Main.BackgroundTransparency = 1
MainStroke.Transparency = 1

task.spawn(function()

	TweenService:Create(
		Main,
		TweenInfo.new(
			0.55,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		),
		{
			Size = OriginalMainSize,
			Position = OriginalMainPosition,
			BackgroundTransparency = 0
		}
	):Play()

	TweenService:Create(
		MainStroke,
		TweenInfo.new(0.45),
		{
			Transparency = 0
		}
	):Play()

end)

--========================================================--
-- HEADER
--========================================================--

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 82)
Header.BackgroundColor3 = Color3.fromRGB(21, 21, 29)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local Accent = Instance.new("Frame")
Accent.Size = UDim2.new(1, 0, 0, 3)
Accent.Position = UDim2.new(0, 0, 1, -3)
Accent.BackgroundColor3 = Settings.Color
Accent.BorderSizePixel = 0
Accent.Parent = Header

local Title = Instance.new("TextLabel")
Title.Position = UDim2.fromOffset(17, 8)
Title.Size = UDim2.new(1, -110, 0, 34)
Title.BackgroundTransparency = 1
Title.Text = "SCRIPTBLOX"
Title.TextColor3 = Settings.Color
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 25
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Position = UDim2.fromOffset(18, 43)
SubTitle.Size = UDim2.new(1, -30, 0, 20)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Advanced Player Visualization"
SubTitle.TextColor3 = Color3.fromRGB(145, 145, 155)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 12
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

local Status = Instance.new("TextLabel")
Status.Position = UDim2.new(1, -95, 0, 13)
Status.Size = UDim2.fromOffset(80, 25)
Status.BackgroundTransparency = 1
Status.Text = "● ON"
Status.TextColor3 = Color3.fromRGB(70, 255, 120)
Status.Font = Enum.Font.GothamBold
Status.TextSize = 12
Status.Parent = Header

--========================================================--
-- HEADER ANIMATIONS
--========================================================--

Title.TextTransparency = 1
SubTitle.TextTransparency = 1
Status.TextTransparency = 1

task.delay(0.15, function()

	TweenService:Create(
		Title,
		TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{
			TextTransparency = 0
		}
	):Play()

end)

task.delay(0.25, function()

	TweenService:Create(
		SubTitle,
		TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{
			TextTransparency = 0
		}
	):Play()

end)

task.delay(0.35, function()

	TweenService:Create(
		Status,
		TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{
			TextTransparency = 0
		}
	):Play()

end)

-- Pulsing accent
task.spawn(function()

	while Accent.Parent do

		TweenService:Create(
			Accent,
			TweenInfo.new(
				0.8,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut
			),
			{
				BackgroundTransparency = 0.35
			}
		):Play()

		task.wait(0.8)

		TweenService:Create(
			Accent,
			TweenInfo.new(
				0.8,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut
			),
			{
				BackgroundTransparency = 0
			}
		):Play()

		task.wait(0.8)

	end

end)

--========================================================--
-- SCROLL
--========================================================--

local Scroll = Instance.new("ScrollingFrame")
Scroll.Position = UDim2.fromOffset(10, 92)
Scroll.Size = UDim2.new(1, -20, 1, -102)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Settings.Color
Scroll.CanvasSize = UDim2.fromOffset(0, 720)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 7)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Scroll

--========================================================--
-- SECTION
--========================================================--

local function Section(text)

	local Label = Instance.new("TextLabel")

	Label.Size = UDim2.new(1, -12, 0, 24)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(110, 110, 125)
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 11
	Label.TextXAlignment = Enum.TextXAlignment.Left

	Label.Parent = Scroll

	return Label
end

--========================================================--
-- BUTTON
--========================================================--

local function Button(text, callback)

	local B = Instance.new("TextButton")

	B.Size = UDim2.new(1, -12, 0, 42)
	B.BackgroundColor3 = Color3.fromRGB(29, 29, 38)
	B.BorderSizePixel = 0
	B.Text = text
	B.TextColor3 = Color3.fromRGB(235, 235, 240)
	B.Font = Enum.Font.GothamBold
	B.TextSize = 14
	B.AutoButtonColor = false

	B.Parent = Scroll

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 9)
	Corner.Parent = B

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(47, 47, 57)
	Stroke.Thickness = 1
	Stroke.Parent = B

	--====================================================--
	-- BUTTON ANIMATIONS
	--====================================================--

	B.MouseEnter:Connect(function()

		TweenService:Create(
			B,
			TweenInfo.new(
				0.15,
				Enum.EasingStyle.Quint,
				Enum.EasingDirection.Out
			),
			{
				BackgroundColor3 = Color3.fromRGB(43, 43, 54),
				Size = UDim2.new(1, -6, 0, 44)
			}
		):Play()

		TweenService:Create(
			Stroke,
			TweenInfo.new(0.15),
			{
				Color = Settings.Color
			}
		):Play()

	end)

	B.MouseLeave:Connect(function()

		TweenService:Create(
			B,
			TweenInfo.new(
				0.15,
				Enum.EasingStyle.Quint,
				Enum.EasingDirection.Out
			),
			{
				BackgroundColor3 = Color3.fromRGB(29, 29, 38),
				Size = UDim2.new(1, -12, 0, 42)
			}
		):Play()

		TweenService:Create(
			Stroke,
			TweenInfo.new(0.15),
			{
				Color = Color3.fromRGB(47, 47, 57)
			}
		):Play()

	end)

	B.MouseButton1Down:Connect(function()

		TweenService:Create(
			B,
			TweenInfo.new(
				0.08,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			{
				Size = UDim2.new(1, -20, 0, 38)
			}
		):Play()

	end)

	B.MouseButton1Up:Connect(function()

		TweenService:Create(
			B,
			TweenInfo.new(
				0.12,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size = UDim2.new(1, -6, 0, 44)
			}
		):Play()

	end)

	B.MouseButton1Click:Connect(callback)

	return B
end

--========================================================--
-- TOGGLE
--========================================================--

local function Toggle(text, setting)

	local B

	local function Update()

		if Settings[setting] then

			B.Text =
				text .. "     ● ON"

			B.TextColor3 =
				Settings.Color

		else

			B.Text =
				text .. "     ○ OFF"

			B.TextColor3 =
				Color3.fromRGB(150, 150, 160)

		end

	end

	B = Button(text, function()

		Settings[setting] =
			not Settings[setting]

		Update()

	end)

	Update()

	return B
end

--========================================================--
-- CONTROLS
--========================================================--

Section("ESP FEATURES")

Toggle("ESP", "Enabled")
Toggle("📦  Boxes", "Boxes")
Toggle("👤  Names", "Names")
Toggle("📏  Distance", "Distance")
Toggle("❤️  Health", "Health")
Toggle("🎯  Tracers", "Tracers")
Toggle("🔴  Highlights", "Highlights")
Toggle("👥  Team Check", "TeamCheck")

Section("ESP SETTINGS")

local DistanceButton

DistanceButton = Button(
	"📡  MAX DISTANCE: 1000",
	function()

		if Settings.MaxDistance == 1000 then
			Settings.MaxDistance = 500
		elseif Settings.MaxDistance == 500 then
			Settings.MaxDistance = 250
		else
			Settings.MaxDistance = 1000
		end

		DistanceButton.Text =
			"📡  MAX DISTANCE: " ..
			Settings.MaxDistance

	end
)

local Colors = {
	{
		Name = "RED",
		Color = Color3.fromRGB(255, 45, 55)
	},

	{
		Name = "GREEN",
		Color = Color3.fromRGB(50, 255, 100)
	},

	{
		Name = "BLUE",
		Color = Color3.fromRGB(50, 160, 255)
	},

	{
		Name = "PURPLE",
		Color = Color3.fromRGB(190, 70, 255)
	},

	{
		Name = "YELLOW",
		Color = Color3.fromRGB(255, 220, 50)
	}
}

local ColorIndex = 1

local ColorButton

ColorButton = Button(
	"🎨  COLOR: RED",
	function()

		ColorIndex += 1

		if ColorIndex > #Colors then
			ColorIndex = 1
		end

		Settings.Color =
			Colors[ColorIndex].Color

		ColorButton.Text =
			"🎨  COLOR: " ..
			Colors[ColorIndex].Name

		Title.TextColor3 =
			Settings.Color

		Accent.BackgroundColor3 =
			Settings.Color

		Scroll.ScrollBarImageColor3 =
			Settings.Color

	end
)

Section("SCRIPTBLOX")

local Credit = Instance.new("TextLabel")

Credit.Size = UDim2.new(1, -12, 0, 45)
Credit.BackgroundTransparency = 1

Credit.Text =
	"SCRIPTBLOX ESP\n" ..
	"Made by Scriptblox  •  RightShift to toggle"

Credit.TextColor3 =
	Color3.fromRGB(120, 120, 135)

Credit.Font = Enum.Font.Gotham
Credit.TextSize = 12
Credit.TextWrapped = true

Credit.Parent = Scroll

--========================================================--
-- ESP
--========================================================--

local function RemoveESP(player)

	local Data = ESPObjects[player]

	if not Data then
		return
	end

	if Data.Highlight then
		Data.Highlight:Destroy()
	end

	if Data.Billboard then
		Data.Billboard:Destroy()
	end

	if Data.Tracer then
		Data.Tracer:Destroy()
	end

	if Data.Box then
		Data.Box:Destroy()
	end

	ESPObjects[player] = nil
end

local function CreateESP(player)

	if player == LocalPlayer then
		return
	end

	if ESPObjects[player] then
		return
	end

	local Character = player.Character

	if not Character then
		return
	end

	local Root =
		Character:FindFirstChild("HumanoidRootPart")

	local Head =
		Character:FindFirstChild("Head")

	if not Root or not Head then
		return
	end

	local Data = {}

	--------------------------------------------------
	-- HIGHLIGHT
	--------------------------------------------------

	local Highlight = Instance.new("Highlight")

	Highlight.Name = "ScriptbloxHighlight"
	Highlight.Adornee = Character

	Highlight.FillColor =
		Settings.Color

	Highlight.OutlineColor =
		Settings.Color

	Highlight.FillTransparency = 0.65
	Highlight.OutlineTransparency = 0

	Highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Highlight.Parent = Character

	Data.Highlight = Highlight

	--------------------------------------------------
	-- HIGHLIGHT ANIMATION
	--------------------------------------------------

	task.spawn(function()

		while Highlight.Parent and ESPObjects[player] do

			TweenService:Create(
				Highlight,
				TweenInfo.new(
					0.9,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					FillTransparency = 0.78
				}
			):Play()

			task.wait(0.9)

			if not Highlight.Parent then
				break
			end

			TweenService:Create(
				Highlight,
				TweenInfo.new(
					0.9,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					FillTransparency = 0.58
				}
			):Play()

			task.wait(0.9)

		end

	end)

	--------------------------------------------------
	-- BILLBOARD
	--------------------------------------------------

	local Billboard = Instance.new("BillboardGui")

	Billboard.Name = "ScriptbloxInfo"
	Billboard.Adornee = Head

	Billboard.Size =
		UDim2.fromOffset(250, 100)

	Billboard.StudsOffset =
		Vector3.new(0, 3.2, 0)

	Billboard.AlwaysOnTop = true
	Billboard.MaxDistance =
		Settings.MaxDistance

	Billboard.Parent = Character

	Data.Billboard = Billboard

	--------------------------------------------------
	-- BILLBOARD ANIMATION
	--------------------------------------------------

	Billboard.StudsOffset = Vector3.new(0, 2.7, 0)

	task.spawn(function()

		TweenService:Create(
			Billboard,
			TweenInfo.new(
				0.45,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				StudsOffset = Vector3.new(0, 3.2, 0)
			}
		):Play()

	end)

	--------------------------------------------------
	-- NAME
	--------------------------------------------------

	local Name = Instance.new("TextLabel")

	Name.Size =
		UDim2.new(1, 0, 0, 25)

	Name.BackgroundTransparency = 1

	Name.Text =
		player.DisplayName ..
		"  @" ..
		player.Name

	Name.TextColor3 =
		Settings.Color

	Name.TextStrokeTransparency = 0

	Name.Font =
		Enum.Font.GothamBold

	Name.TextSize = 15

	Name.TextTransparency = 1

	Name.Parent = Billboard

	Data.Name = Name

	--------------------------------------------------
	-- DISTANCE
	--------------------------------------------------

	local Distance = Instance.new("TextLabel")

	Distance.Position =
		UDim2.fromOffset(0, 25)

	Distance.Size =
		UDim2.new(1, 0, 0, 20)

	Distance.BackgroundTransparency = 1

	Distance.TextColor3 =
		Color3.fromRGB(220, 220, 220)

	Distance.TextStrokeTransparency = 0

	Distance.Font =
		Enum.Font.Gotham

	Distance.TextSize = 13

	Distance.TextTransparency = 1

	Distance.Parent = Billboard

	Data.Distance = Distance

	--------------------------------------------------
	-- HEALTH
	--------------------------------------------------

	local Health = Instance.new("TextLabel")

	Health.Position =
		UDim2.fromOffset(0, 45)

	Health.Size =
		UDim2.new(1, 0, 0, 20)

	Health.BackgroundTransparency = 1

	Health.TextColor3 =
		Color3.fromRGB(255, 255, 255)

	Health.TextStrokeTransparency = 0

	Health.Font =
		Enum.Font.Gotham

	Health.TextSize = 13

	Health.TextTransparency = 1

	Health.Parent = Billboard

	Data.Health = Health

	-- Fade billboard information in
	task.spawn(function()

		task.wait(0.05)

		TweenService:Create(
			Name,
			TweenInfo.new(0.35),
			{
				TextTransparency = 0
			}
		):Play()

		task.wait(0.05)

		TweenService:Create(
			Distance,
			TweenInfo.new(0.35),
			{
				TextTransparency = 0
			}
		):Play()

		task.wait(0.05)

		TweenService:Create(
			Health,
			TweenInfo.new(0.35),
			{
				TextTransparency = 0
			}
		):Play()

	end)

	--------------------------------------------------
	-- TRACER
	--------------------------------------------------

	local Tracer = Instance.new("Frame")

	Tracer.Name = "ScriptbloxTracer"

	Tracer.AnchorPoint =
		Vector2.new(0.5, 0.5)

	Tracer.BorderSizePixel = 0

	Tracer.BackgroundColor3 =
		Settings.Color

	Tracer.Visible = false

	Tracer.Parent = Gui

	Data.Tracer = Tracer

	--------------------------------------------------
	-- BOX
	--------------------------------------------------

	local Box = Instance.new("Frame")

	Box.Name = "ScriptbloxBox"

	Box.BackgroundTransparency = 1
	Box.BorderSizePixel = 0

	Box.Visible = false
	Box.Parent = Gui

	local BoxStroke = Instance.new("UIStroke")

	BoxStroke.Color =
		Settings.Color

	BoxStroke.Thickness = 2

	BoxStroke.Parent = Box

	Data.Box = Box

	ESPObjects[player] = Data
end

--------------------------------------------------
-- PLAYER SETUP
--------------------------------------------------

local function SetupPlayer(player)

	if player == LocalPlayer then
		return
	end

	player.CharacterAdded:Connect(function()

		task.wait(0.5)

		RemoveESP(player)
		CreateESP(player)

	end)

	player.CharacterRemoving:Connect(function()

		RemoveESP(player)

	end)

	if player.Character then
		task.wait()
		CreateESP(player)
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	SetupPlayer(player)
end

Players.PlayerAdded:Connect(SetupPlayer)

Players.PlayerRemoving:Connect(function(player)

	RemoveESP(player)

end)

--------------------------------------------------
-- UPDATE ESP
--------------------------------------------------

RunService.RenderStepped:Connect(function()

	for player, Data in pairs(ESPObjects) do

		local Character = player.Character

		if not Character then
			continue
		end

		local Root =
			Character:FindFirstChild(
				"HumanoidRootPart"
			)

		local Humanoid =
			Character:FindFirstChildOfClass(
				"Humanoid"
			)

		if not Root then
			continue
		end

		local LocalCharacter =
			LocalPlayer.Character

		local LocalRoot =
			LocalCharacter
			and LocalCharacter:FindFirstChild(
				"HumanoidRootPart"
			)

		if not LocalRoot then
			continue
		end

		--------------------------------------------------
		-- DISTANCE
		--------------------------------------------------

		local Distance =
			(LocalRoot.Position -
			Root.Position).Magnitude

		local InRange =
			Distance <= Settings.MaxDistance

		--------------------------------------------------
		-- TEAM
		--------------------------------------------------

		local SameTeam =
			Settings.TeamCheck
			and player.Team == LocalPlayer.Team

		if not Settings.Enabled
			or not InRange
			or SameTeam then

			if Data.Highlight then
				Data.Highlight.Enabled = false
			end

			if Data.Billboard then
				Data.Billboard.Enabled = false
			end

			if Data.Tracer then
				Data.Tracer.Visible = false
			end

			if Data.Box then
				Data.Box.Visible = false
			end

			continue
		end

		--------------------------------------------------
		-- HIGHLIGHT
		--------------------------------------------------

		if Data.Highlight then

			Data.Highlight.Enabled =
				Settings.Highlights

			Data.Highlight.FillColor =
				Settings.Color

			Data.Highlight.OutlineColor =
				Settings.Color

		end

		--------------------------------------------------
		-- BILLBOARD
		--------------------------------------------------

		if Data.Billboard then

			Data.Billboard.Enabled = true

			Data.Billboard.MaxDistance =
				Settings.MaxDistance

		end

		--------------------------------------------------
		-- NAME
		--------------------------------------------------

		if Data.Name then

			Data.Name.Visible =
				Settings.Names

			Data.Name.TextColor3 =
				Settings.Color

		end

		--------------------------------------------------
		-- DISTANCE
		--------------------------------------------------

		if Data.Distance then

			Data.Distance.Visible =
				Settings.Distance

			Data.Distance.Text =
				math.floor(Distance) ..
				" studs"

		end

		--------------------------------------------------
		-- HEALTH
		--------------------------------------------------

		if Data.Health then

			Data.Health.Visible =
				Settings.Health

			if Humanoid then

				Data.Health.Text =
					"❤ " ..
					math.floor(
						Humanoid.Health
					) ..
					" / " ..
					math.floor(
						Humanoid.MaxHealth
					)

			end

		end

		--------------------------------------------------
		-- TRACER
		--------------------------------------------------

		if Data.Tracer then

			if Settings.Tracers then

				local Position, OnScreen =
					Camera:WorldToViewportPoint(
						Root.Position
					)

				if OnScreen then

					local Start =
						Vector2.new(
							Camera.ViewportSize.X / 2,
							Camera.ViewportSize.Y
						)

					local End =
						Vector2.new(
							Position.X,
							Position.Y
						)

					local Difference =
						End - Start

					Data.Tracer.Visible = true

					Data.Tracer.Position =
						UDim2.fromOffset(
							(Start.X + End.X) / 2,
							(Start.Y + End.Y) / 2
						)

					Data.Tracer.Size =
						UDim2.fromOffset(
							Difference.Magnitude,
							2
						)

					Data.Tracer.Rotation =
						math.deg(
							math.atan2(
								Difference.Y,
								Difference.X
							)
						)

					Data.Tracer.BackgroundColor3 =
						Settings.Color

				else

					Data.Tracer.Visible = false

				end

			else

				Data.Tracer.Visible = false

			end

		end

		--------------------------------------------------
		-- BOX
		--------------------------------------------------

		if Data.Box then

			if Settings.Boxes then

				local Position, OnScreen =
					Camera:WorldToViewportPoint(
						Root.Position
					)

				if OnScreen then

					local DistanceScale =
						math.clamp(
							100 /
							math.max(Distance, 1),
							0.3,
							2
						)

					local Width =
						100 * DistanceScale

					local Height =
						160 * DistanceScale

					Data.Box.Visible = true

					Data.Box.Size =
						UDim2.fromOffset(
							Width,
							Height
						)

					Data.Box.Position =
						UDim2.fromOffset(
							Position.X - Width / 2,
							Position.Y - Height / 2
						)

					local Stroke =
						Data.Box:FindFirstChildOfClass(
							"UIStroke"
						)

					if Stroke then
						Stroke.Color =
							Settings.Color
					end

				else

					Data.Box.Visible = false

				end

			else

				Data.Box.Visible = false

			end

		end

	end

	--------------------------------------------------
	-- STATUS
	--------------------------------------------------

	if Settings.Enabled then

		Status.Text = "● ON"
		Status.TextColor3 =
			Color3.fromRGB(70, 255, 120)

	else

		Status.Text = "● OFF"
		Status.TextColor3 =
			Color3.fromRGB(255, 70, 70)

	end

end)

--========================================================--
-- STATUS PULSE ANIMATION
--========================================================--

task.spawn(function()

	while Status.Parent do

		TweenService:Create(
			Status,
			TweenInfo.new(
				0.7,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut
			),
			{
				TextTransparency = 0.25
			}
		):Play()

		task.wait(0.7)

		TweenService:Create(
			Status,
			TweenInfo.new(
				0.7,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut
			),
			{
				TextTransparency = 0
			}
		):Play()

		task.wait(0.7)

	end

end)

--------------------------------------------------
-- RIGHT SHIFT TOGGLE
--------------------------------------------------

UIS.InputBegan:Connect(function(input)

	if input.KeyCode ==
		Enum.KeyCode.RightShift then

		Main.Visible =
			not Main.Visible

		--================================================--
		-- GUI OPEN/CLOSE ANIMATION
		--================================================--

		if Main.Visible then

			Main.Size = UDim2.fromOffset(320, 470)
			Main.BackgroundTransparency = 0.15

			TweenService:Create(
				Main,
				TweenInfo.new(
					0.35,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out
				),
				{
					Size = OriginalMainSize,
					BackgroundTransparency = 0
				}
			):Play()

			TweenService:Create(
				MainStroke,
				TweenInfo.new(0.3),
				{
					Transparency = 0
				}
			):Play()

		else

			TweenService:Create(
				Main,
				TweenInfo.new(
					0.2,
					Enum.EasingStyle.Quad,
					Enum.EasingDirection.In
				),
				{
					Size = UDim2.fromOffset(320, 470),
					BackgroundTransparency = 1
				}
			):Play()

		end

	end

end)

--------------------------------------------------
-- DRAG WINDOW
--------------------------------------------------

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		Dragging = true
		DragStart = input.Position
		StartPosition = Main.Position

	end

end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		Dragging = false

	end

end)

UIS.InputChanged:Connect(function(input)

	if not Dragging then
		return
	end

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement then

		local Delta =
			input.Position - DragStart

		Main.Position =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,

				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)

	end

end)
