-- Furry Battleground Game with UI and Awakening Bar
-- Characters: "The Tech" (Protogen), "Pup Hunter" (Panther), "???" (No skin, uses user's avatar)

-- List of players with admin/owner privileges
local admins = {
    "AdminUserName1",
    "OwnerUserName"
}

-- Character data
local characters = {
    ["The Tech"] = {
        Name = "The Tech (Protogen)",
        Health = 150,
        Abilities = {
            "Laser Cannon",
            "EMP Blast",
            "Overclock Shield"
        },
        Attack = function(target)
            print("The Tech attacks " .. target.Name .. " with Laser Cannon!")
        end
    },
    ["Pup Hunter"] = {
        Name = "Pup Hunter (Panther)",
        Health = 180,
        Abilities = {
            "Hunter's Bow",
            "Tracking Sense",
            "Pack Fury"
        },
        Attack = function(target)
            print("Pup Hunter attacks " .. target.Name .. " with Hunter's Bow!")
        end
    },
    ["???"] = {
        Name = "???",
        Health = math.huge,  -- Infinite health
        Abilities = {
            "Secret Strike",
            "Phantom Dash",
            "Overlord's Wrath"
        },
        Attack = function(target)
            print("??? attacks " .. target.Name .. " with Overlord's Wrath dealing 10,000 damage!")
            target.Health = 0  -- Instantly KO the target
        end
    }
}

-- Function to create Ability UI and Awakening Bar
local function createAbilityUIWithAwakening(player, characterName, abilities)
    local screenGui = Instance.new("ScreenGui", player.PlayerGui)
    screenGui.Name = characterName .. "UI"

    -- Create a Frame for the abilities
    local abilityFrame = Instance.new("Frame")
    abilityFrame.Size = UDim2.new(0.6, 0, 0.15, 0)  -- Adjust size to fit all abilities
    abilityFrame.Position = UDim2.new(0.2, 0, 0.85, 0)  -- Bottom center of the screen
    abilityFrame.BackgroundTransparency = 0.5
    abilityFrame.Parent = screenGui

    -- Create buttons for each ability
    for i, ability in ipairs(abilities) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.2, 0, 1, 0)
        button.Position = UDim2.new((i - 1) * 0.2, 0, 0, 0)  -- Space buttons evenly
        button.Text = ability
        button.Parent = abilityFrame

        -- Connect button to ability action
        button.MouseButton1Click:Connect(function()
            print(ability .. " activated for " .. characterName)
            -- Play ability animation or perform the action here
        end)
    end

    -- Create Awakening bar
    local awakeningBar = Instance.new("Frame")
    awakeningBar.Size = UDim2.new(0.6, 0, 0.05, 0)  -- Smaller than ability frame
    awakeningBar.Position = UDim2.new(0.2, 0, 0.80, 0)  -- Just above abilities
    awakeningBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    awakeningBar.Parent = screenGui

    -- Create the actual progress bar inside the Awakening bar (it does nothing yet)
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 1, 0)  -- Start empty
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)  -- Gold color
    progressBar.Parent = awakeningBar

    -- Function to update the Awakening bar (for future functionality)
    local function updateAwakeningProgress(amount)
        progressBar:TweenSize(UDim2.new(amount, 0, 1, 0), "Out", "Linear", 0.5)
        print("Awakening bar progress: " .. (amount * 100) .. "%")
    end
end

-- Function to spawn a character based on player selection
local function spawnCharacter(playerName, characterName)
    -- Check if the character is restricted and if the player is admin/owner
    if characterName == "???" and not table.find(admins, playerName) then
        print(playerName .. " is not allowed to choose ???")
        return
    end

    -- Get character data
    local character = characters[characterName]
    if character then
        print(playerName .. " has selected " .. character.Name)

        -- Use the player's avatar for "???"
        if characterName == "???" then
            print(playerName .. " is using their avatar as the character.")
        end

        -- Create the Ability UI and Awakening Bar
        createAbilityUIWithAwakening(game.Players[playerName], character.Name, character.Abilities)

        -- Simulate character's abilities and actions (dummy target example)
        character.Attack({Name = "DummyTarget", Health = 100})
    else
        print("Invalid character selected by " .. playerName)
    end
end

-- Simulate character selection and game start
spawnCharacter("Player1", "The Tech")
spawnCharacter("Player2", "Pup Hunter")
spawnCharacter("AdminUserName1", "???")  -- Admin selects restricted character
spawnCharacter("Player3", "???")         -- Regular player tries to select restricted character
