local Utility = loadstring(game:HttpGet("https://raw.githubusercontent.com/TempedOut/test/main/Utitlity.lua"))()

local PlayerEsp = {
    Threads = {},
    Connections = {
        PlayerAdded = nil,
        PlayerRemoving = nil
    },
    Esp = {},
    Settings = {
        Color = Color3.fromRGB(255, 0, 0)
    }
}

function PlayerEsp:Init()
    for _, Player in Utility:ListPlayers() do
        if Player ~= game.Players.LocalPlayer then
            self:Add(Player)
        end
    end

    self.Connections = Utility.RunService.Heartbeat:Connect(function()
        self.Check()
    end)

    --self.Connections.PlayerAdded = game.Players.PlayerAdded:Connect(function(Player)
        --self:Add(Player)
    --end)

    --self.Connections.PlayerRemoving = game.Players.PlayerRemoving:Connect(function(Player)
        --self:Remove(Player)
    --end)
end

function PlayerEsp:Add(Player)

    local PlayerName = tostring(Player.Name)

    self.Esp[PlayerName] = {Box = Drawing.new("Square"), Name = Drawing.new("Text")}

    self.Esp[PlayerName].Box.Color = self.Settings.Color
    self.Esp[PlayerName].Box.Thickness = 1
    self.Esp[PlayerName].Box.Transparency = 1
    self.Esp[PlayerName].Box.Filled = false
    self.Esp[PlayerName].Box.Visible = false

    self.Esp[PlayerName].Name.Visible = false
    self.Esp[PlayerName].Name.Center = true
    self.Esp[PlayerName].Name.Outline = true
    self.Esp[PlayerName].Name.Font = 1
    self.Esp[PlayerName].Name.Color = self.Settings.Color
    self.Esp[PlayerName].Name.Size = 13

end

function PlayerEsp:Check()

    local myPlayer = game.Players.LocalPlayer
    local Camera = Utility:GetCamera()
    local world_to_viewport_point = Camera.worldToViewportPoint

    local head_offset = Vector3.new(0, 0.5, 0)
    local leg_offset = Vector3.new(0, 3, 0)

    for i, player in Utility:ListPlayers() do
        
        local PlayerName = tostring(player.Name)

        if player ~= myPlayer then
            
            if player.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") ~= nil and player.Character.Humanoid.Health > 0 then

                local Vector, onScreen = Camera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)

                local player_hmrp = player.Character.HumanoidRootPart
                local player_head = player.Character.Head

                local root_position = world_to_viewport_point(Camera, player_hmrp.Position)
                local head_position = world_to_viewport_point(Camera, player_head.Position + head_offset)
                local leg_position = world_to_viewport_point(Camera, player_hmrp.Position - leg_offset)

                if onScreen then
                    
                    self.Esp[PlayerName].Box.Size = Vector2.new(2560 / root_position.Z, head_position.Y - leg_position.Y)
                    self.Esp[PlayerName].Box.Position = Vector2.new(root_position.X - self.Esp[PlayerName].Box.Size.X / 2, root_position.Y - self.Esp[PlayerName].Box.Size.Y / 2)

                    self.Esp[PlayerName].Name.Position = Vector2.new(Vector.X, Vector.Y)
                    self.Esp[PlayerName].Name.Text = PlayerName

                    self.Esp[PlayerName].Box.Visible = true
                    self.Esp[PlayerName].Name.Visible = true

                else
                    self.Esp[PlayerName].Box.Visible = false
                    self.Esp[PlayerName].Name.Visible = false
                end

            else
                self.Esp[PlayerName].Box.Visible = false
                self.Esp[PlayerName].Name.Visible = false
            end

        end

    end

end

function PlayerEsp:Remove(Player)
    local PlayerName = tostring(Player)

    self.Esp[PlayerName].Box:Destroy()
    self.Esp[PlayerName].Name:Destroy()
    self.Esp[PlayerName]:Remove()
end

function PlayerEsp:Unload()

end

return PlayerEsp
