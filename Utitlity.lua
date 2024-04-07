local Utility = {
    UIS = game:GetService("UserInputService"),
    VIM = Instance.new("VirtualInputManager"),
    RunService = game:GetService("RunService")
}

function Utility:ListPlayers()
    return game.Players:GetPlayers()
end

function Utility:GetCamera()
    return game.Workspace.Camera
end

return Utility
