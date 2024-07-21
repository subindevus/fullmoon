local Webhook = "https://discord.com/api/webhooks/1264425262708297779/G4A8527-OwENgzFslEgFXMn0zOeidXoEiHa78d_2lVkpVP7_c7b1UoGjOGM13QInIQvR"

local MoonPhases = {
    {url = "http://www.roblox.com/asset/?id=9709149680", icon = '🌔'},
    {url = "http://www.roblox.com/asset/?id=9709150086", icon = '🌓'},
    {url = "http://www.roblox.com/asset/?id=9709139597", icon = '🌖'},
    {url = "http://www.roblox.com/asset/?id=9709135895", icon = '🌑'},
    {url = "http://www.roblox.com/asset/?id=9709150401", icon = '🌘'},
    {url = "http://www.roblox.com/asset/?id=9709143733", icon = '🌓'},
    {url = "http://www.roblox.com/asset/?id=9709149052", icon = '🌖'},
    {url = "http://www.roblox.com/asset/?id=9709149431", icon = '🌕'}
}

local lighting = game:GetService('Lighting')
local moonTextureId = lighting.Sky.MoonTextureId

local function getMoonPhaseInfo(moonTextureId)
    for i, phase in ipairs(MoonPhases) do
        if moonTextureId == phase.url then
            return i, (i / #MoonPhases) * 100, phase.icon
        end
    end
    return 1, 0, MoonPhases[1].icon
end

local moonIndex, MoonPercent, MoonIcon = getMoonPhaseInfo(moonTextureId)
local PlayersMin = #game.Players:GetPlayers()

local Player = game.Players.LocalPlayer
local PlayerName = Player.Name
local PlayerUserId = Player.UserId
local PlayerPing = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()

local MoonMessage = ('```' .. MoonIcon .. ' : %.2f%%```'):format(MoonPercent)
if MoonPercent == 100 then
    MoonMessage = MoonMessage .. ' - 𝐓𝐫𝐚̆𝐧𝐠 𝐓𝐫𝐨̀𝐧'
end

local color = MoonPercent == 100 and 0xFFFF00 or 0x8B0000

local HttpService = game:GetService("HttpService")
local waifuResponse = HttpService:JSONDecode(game:HttpGet("https://api.waifu.pics/sfw/waifu"))
local waifuUrl = waifuResponse.url

local Embed = {
    username = "𝐅𝐔𝐋𝐋 𝐌𝐎𝐎𝐍",
    avatar_url = "https://cdn.top.gg/icons/15ffc41e863b684677d831ace7bf41dc.png",
    embeds = {{
        title = "❤️ 𝐍𝐨𝐭𝐢𝐟𝐲 𝐅𝐮𝐥𝐥 𝐌𝐨𝐨𝐧 𝐁𝐥𝐨𝐱 𝐅𝐚𝐦𝐢𝐥𝐲 ❤️",
        color = color,
        type = "rich",
        fields = {
            { name = "[🌕] 𝐌𝐨𝐨𝐧 𝐏𝐡𝐚𝐬𝐞:", value = MoonMessage, inline = true },
            { name = "[👥] 𝐏𝐥𝐚𝐲𝐞𝐫𝐬 𝐈𝐧 𝐒𝐞𝐫𝐯𝐞𝐫:", value = ('```%d/12```'):format(PlayersMin), inline = true },
            { name = "[🔗] 𝐒𝐜𝐫𝐢𝐩𝐭 𝐉𝐨𝐢𝐧 𝐒𝐞𝐫𝐯𝐞𝐫:", value = ('```game.ReplicatedStorage[\'__ServerBrowser\']:InvokeServer(\'teleport\', \'%s\')```'):format(game.JobId), inline = false },
            { name = "[📶] 𝐒𝐞𝐫𝐯𝐞𝐫 𝐏𝐢𝐧𝐠:", value = ('```%s ms```'):format(PlayerPing), inline = true },
            { name = "[🎮] 𝐆𝐚𝐦𝐞 𝐕𝐞𝐫𝐬𝐢𝐨𝐧:", value = ('```%s```'):format(game.PlaceVersion), inline = true },
            { name = "[👤] 𝐏𝐥𝐚𝐲𝐞𝐫 𝐔𝐬𝐢𝐧𝐠 𝐒𝐜𝐫𝐢𝐩𝐭:", value = ('```%s```'):format(PlayerName, PlayerUserId), inline = true },
        },
        thumbnail = { url = MoonPhases[moonIndex].url },
        image = { url = waifuUrl },
        footer = {
            text = os.date("𝐓𝐢𝐦𝐞: %X").." | 𝐒𝐮𝐛𝐢𝐧 𝐁𝐨𝐭 | 𝐂𝐫𝐞𝐚𝐭𝐞 𝐁𝐲 𝐒𝐮𝐛𝐢𝐧 𝐃𝐞𝐯 | https://discord.gg/BxjqHMMsTb",
            icon_url = "https://cdn.top.gg/icons/15ffc41e863b684677d831ace7bf41dc.png"
        }
    }}
}

local Data = HttpService:JSONEncode(Embed)
local Headers = {["content-type"] = "application/json"}
local Send = http_request or request or HttpPost or syn.request

Send({ Url = Webhook, Body = Data, Method = "POST", Headers = Headers })
