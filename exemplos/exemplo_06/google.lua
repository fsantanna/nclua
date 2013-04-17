require 'tcp'

function handler (evt)
	if evt.class  ~= 'ncl'         then return end
    if evt.type   ~= 'attribution' then return end
    if evt.action ~= 'start'       then return end
    if evt.name   ~= 'search'      then return end

	event.post {
        class  = 'ncl',
        type   = 'attribution',
        name   = 'search',
        action = 'stop',
    }

    tcp.execute(
        function ()
            tcp.connect('www.google.com.br', 80)
            tcp.send('GET /search?hl=pt-BR&btnI&q='..evt.value..'\n')
            local result = tcp.receive()
            if result then
		        result = string.match(result, 'Location: http://(.-)\r?\n') or 'nao encontrado'
	        else
		        result = 'error: ' .. evt.error
	        end
	        local evt = {
		        class = 'ncl',
		        type  = 'attribution',
		        name  = 'result',
		        value = result,
	        }
            evt.action = 'start'; event.post(evt)
            evt.action = 'stop' ; event.post(evt)
            tcp.disconnect()
        end
    )
end
event.register(handler)
