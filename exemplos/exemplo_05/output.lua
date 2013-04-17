local TEXT = ''

local dx, dy = canvas:attrSize()
canvas:attrFont('vera', 3*dy/4)
function redraw ()
	canvas:attrColor('black')
	canvas:drawRect('fill', 0,0, dx,dy)

	canvas:attrColor('white')
	canvas:drawText(0,0, TEXT)

	canvas:flush()
end

local function handler (evt)
	if evt.class ~= 'ncl' then return end

	if evt.type == 'attribution' then
		if evt.name == 'text' then
			if evt.action == 'start' then
				TEXT = evt.value
				evt.action = 'stop'
				event.post(evt)
			end
		end
	end

	redraw()
end

event.register(handler)
