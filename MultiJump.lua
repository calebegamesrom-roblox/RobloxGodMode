-- Script de Múltiplos Pulos para Roblox
-- Coloque este script em StarterPlayer > StarterCharacterScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Configurações
local JUMP_POWER = 50 -- Força do pulo
local lastJumpTime = 0 -- Para evitar spam de pulos
local JUMP_COOLDOWN = 0.1 -- Tempo mínimo entre pulos (em segundos)

-- Detector de toque no chão
local function isGrounded()
	local rayOrigin = rootPart.Position
	local rayDirection = Vector3.new(0, -5, 0)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {character}
	
	local rayResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
	return rayResult ~= nil
end

-- Função para fazer o personagem pular (infinito)
local function jump()
	local currentTime = tick()
	if currentTime - lastJumpTime >= JUMP_COOLDOWN then
		lastJumpTime = currentTime
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		rootPart.AssemblyLinearVelocity = Vector3.new(
			rootPart.AssemblyLinearVelocity.X,
			JUMP_POWER,
			rootPart.AssemblyLinearVelocity.Z
		)
	end
end

-- Detector de entrada (Spacebar)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.Space then
		jump()
	end
end)
