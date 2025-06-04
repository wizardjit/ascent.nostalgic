local TitleLabel = instance.new("TextLabel", {
    Parent = TopBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 298, 0, 29),
    TextColor3 = Color3.fromRGB(75, 75, 75),
    RichText = true,
    Text = "spoof.<font color=\"rgb(115, 100, 215)\">xyz</font>",
    FontFace = Fonts.ProggyTiny,
    TextSize = 9
})

local InjectButton = instance.new("TextButton", {
    Parent = Background,
    BackgroundColor3 = Color3.fromRGB(11, 11, 11),
    BorderColor3 = Color3.fromRGB(22, 22, 22),
    BorderMode = Enum.BorderMode.Inset,
    BorderSizePixel = 1,
    Position = UDim2.new(0.167, 0, 0.814, 0),
    Size = UDim2.new(0, 200, 0, 50),
    FontFace = Fonts.ProggyTiny,
    TextSize = 9,
    Text = "Inject . . .",
    TextColor3 = Color3.fromRGB(125, 125, 125),
    AutoButtonColor = false
})

local injection_finish = false

InjectButton.MouseButton1Click:Connect(function()
    if Game_Version then
        local texts = {"Injecting.", "Injecting..", "Injected..."}
        for i = 1, 1 do
            if injection_finish then break end
            for _, text in ipairs(texts) do
                InjectButton.Text = text
                wait(0.5)
            end
        end
        if not injection_finish then
            injection_finish = true
            for i, v in pairs(Loader:GetDescendants()) do
                v:Destroy()
            end
            Cursor:Destroy()
            CursorOutline:Destroy()
            UserInputService.MouseIconEnabled = true

            pcall(function()
                loadstring(game:HttpGet("https://pastebin.com/raw/vym3VE7f", true))()
            end)
        end
    else
        local message_response = messagebox('spoof.xyz', 'Game has updated, are you sure you want to proceed?', 1)
        if message_response == 1 then
            local texts = {"Injecting.", "Injecting..", "Injected..."}
            for i = 1, 1 do
                if injection_finish then break end
                for _, text in ipairs(texts) do
                    InjectButton.Text = text
                    wait(0.5)
                end
            end
            if not injection_finish then
                injection_finish = true
                for i, v in pairs(Loader:GetDescendants()) do
                    v:Destroy()
                end
                Cursor:Destroy()
                CursorOutline:Destroy()
                UserInputService.MouseIconEnabled = true

                pcall(function()
                    loadstring(game:HttpGet("https://pastebin.com/raw/vym3VE7f", true))()
                end)
            end
        end
    end
end)

do
    local UIStroke = instance.new("UIStroke", {
        Parent = InjectButton,
        Color = Color3.fromRGB(0, 0, 0),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })

    InjectButton.MouseEnter:Connect(function()
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local tweenProperties = { Color = Color3.fromRGB(115, 100, 215) }
        local tween = Tween:Create(UIStroke, tweenInfo, tweenProperties)
        tween:Play()
    end)

    InjectButton.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenProperties = { Color = Color3.fromRGB(0, 0, 0) }
        local tween = Tween:Create(UIStroke, tweenInfo, tweenProperties)
        tween:Play()
    end)
end

for i, v in pairs(Loader:GetDescendants()) do
    if not v:IsA("ImageLabel") and not v:IsA("TextLabel") and not v:IsA("ScrollingFrame") and not v:IsA("UIStroke") and not v:IsA("UIListLayout") then
        TweenOpen(v)
    end
end

do -- drag
    local gui, dragging, dragInput, dragStart, startPos = Glow_Around
    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

return Loader
--Loader:Initialize()
