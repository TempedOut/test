local Utility = {
    UIS = Instance.new("UserInputService"),
    VIM = Instance.new("VirtualInputManager"),
    RunService = Instance.new("RunService")
}

function Utility:ListPlayers()
    return game.Players:GetPlayers()
end

function Utility:GetCamera()
    return game.Workspace.Camera
end

return Utility
