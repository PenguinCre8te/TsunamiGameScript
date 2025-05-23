local player = game.Players.LocalPlayer

local function teleportLoop(character)
    local rootPart = character:WaitForChild("HumanoidRootPart") -- Ensure teleport works

    while true do  -- Infinite loop
        local collisionParts = {}

        -- Search for all "CoinCollision" parts
        for _, part in ipairs(game.Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Name == "CoinCollision" then
                table.insert(collisionParts, part)
            end
        end

        print("[DEBUG] Found " .. #collisionParts .. " CoinCollision parts.")

        if #collisionParts == 0 then
            warn("[DEBUG] No CoinCollision parts found! Retrying...")
            wait(5) -- Wait before checking again
        else
            for index, part in ipairs(collisionParts) do
                wait(0.1) -- Delay before teleporting
                print("[DEBUG] Teleporting to CoinCollision #" .. index .. " at position: " .. tostring(part.Position))
                rootPart.CFrame = part.CFrame
            end
        end
    end
end

-- Function to start teleportation when the player spawns
local function onCharacterAdded(character)
    print("[DEBUG] Player respawned. Restarting teleport loop...")
    teleportLoop(character)
end

-- Detect when the player respawns
player.CharacterAdded:Connect(onCharacterAdded)

-- Start teleporting if the player already has a character
if player.Character then
    teleportLoop(player.Character)
end
