local api = require("fromage")
local client = api()
local enumerations = client.enumerations()
login_account = 1;
cities = {"Rio de Janeiro/RJ", "Florianópolis/SC", "São Paulo/SP", "Búzios/RJ", "Salvador/BA", "Foz do Iguaçu/PR", "Paraty/RJ", "Manaus/AM", "Bonito/MS", "Trancoso/BA"}

local normalizeHTML
do
	local entities = {
		["&amp;"] = '&',
		["&lt;"] = '<',
		["&gt;"] = '>',
		["&laquo;"] = '«',
		["&raquo;"] = '»',
		["&quot;"] = '"'
	}
	normalizeHTML = function(title)
		title = string.gsub(title, "&#(%d+);", function(dec)
			return string.char(dec)
		end)
		title = string.gsub(title, "&.-;", function(e)
			return entities[e] or e
		end)

		return title
	end
end

function sl(text)
	print("\n["..os.date('%d/%m/%Y %H:%M').."] "..text)
end


coroutine.wrap(function()
	if (login_account == 1) then
		client.connect("Viccentbruno#6410", "Viccent2018159753")
	else
		client.connect("Bruno#3852", "Uc0wre1I*lDun12")
	end
	
	if client.isConnected() then
		sl("Conectado como "..client.getUser());
		
		local enviaMensagem = client.answerConversation(1589616, "Estou conectado novamente\n"..os.date('%d/%m/%Y %H:%M'))
		if enviaMensagem then sl("Mensagem de início enviada") end
		
		if (login_account==1) then
		
			--Lendo tópicos da conta
			local topics, err = client.getCreatedTopics("Bruno#3852") -- Gets the topics created by someone
			
			data={}
			row = "[url=https://atelier801.com/topic?%s]%s[/url]";
		if topics then
			for i = 1, #topics do
				data[i] = string.format(row, topics[i]["location"].raw_data, normalizeHTML(topics[i].title));
			end
		else
			print(err)
		end
		--fim da leitura
			
			local updateProfile = client.updateProfile({
				presentation="Bot pertecente a: [url=https://atelier801.com/profile?pr=Bruno%233852]Bruno#3852[/url]\nÚltimo login: "..os.date('%d/%m/%Y %H:%M').."[hr]Minha funções atuais:\n\n• Eu altero minha localização para uma cidade famosa toda vez que entro.[hr]Tópicos criados pelo meu criador (atualizado automaticamente):\n\n"..table.concat(data, "\n"),
				location = cities[math.random(#cities)]
			})
			if updateProfile then sl("Perfil atualizado") end
		end
	end

	client.disconnect()
	os.execute("pause >nul")
end)()