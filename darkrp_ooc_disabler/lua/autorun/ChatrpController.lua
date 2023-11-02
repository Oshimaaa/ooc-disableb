
local command_name = "hrp"
local command_delay = 1.5
local admin_use = true


hook.Add("PostGamemodeLoaded", "Gmod.Workshop.ChatHrp", function()

	if not DarkRP then

		timer.Create("Gmod.Workshop.ChatHrp", 30, 0, function()

			local players = player.GetAll()

			for i = 1, #players do

				players[i]:ChatPrint("L'addon \"[JJK] Chat RP\" n'a pas chargé car il fonctionne uniquement sur le mode de jeu DarkRP ou mangaRP.")

			end

		end)

		return

	end

	if SERVER then


		local function OOC_CONTROL(ply, args)

			if ply:IsAdmin() then

				local playerName = ply:Nick()

				if GAMEMODE.Config.ooc then

					DarkRP.notifyAll(0, 5, "Le chat HRP a été désactivé par " .. playerName .. ".")

				else

					DarkRP.notifyAll(0, 5, "Le chat HRP a été activé par " .. playerName .. ".")

				end

				GAMEMODE.Config.ooc = not GAMEMODE.Config.ooc

			else

				DarkRP.notify("Vous n'êtes pas autorisé à exécuter cette commande.")

			end

			return ""

		end
		DarkRP.defineChatCommand(command_name, OOC_CONTROL)


		if admin_use then

			local function OOC(ply, args)

				if not GAMEMODE.Config.ooc and not ply:IsAdmin() then
					DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("désactivé", DarkRP.getPhrase("chat hrp"), ""))
					return ""
				end

				local DoSay = function(text)

					if text == "" then
						DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
						return ""
					end

					local col = team.GetColor(ply:Team())
					local col2 = Color(255, 255, 255, 255)
					if not ply:Alive() then
						col2 = Color(255, 200, 200, 255)
						col = col2
					end

					local phrase = DarkRP.getPhrase("ooc")
					local name = ply:Nick()
					for _, v in ipairs(player.GetAll()) do
						DarkRP.talkToPerson(v, col, "(" .. phrase .. ") " .. name, col2, text, ply)
					end

				end

				return args, DoSay

			end
			DarkRP.defineChatCommand("/", OOC)
			DarkRP.defineChatCommand("a", OOC)
			DarkRP.defineChatCommand("ooc", OOC)

		end

	end

	DarkRP.declareChatCommand({

		command = command_name,
		description = "Permets de désactiver le chat hrp.",
		delay = command_delay

	})

end)

