function love.draw()
	love.graphics.print("SPACEGAME", 400, 400)
	for i,body in ipairs(bodies) do
		love.graphics.circle("line", body.x, body.y, 10)
	end
end

function love.update()
	for i,body in ipairs(bodies) do 
		updateBody(body)
	end
end

function love.load()
	bodies = {}
	for i=1,10 do
		bodies[i]=createBody(math.random(love.graphics.getWidth()), 
			math.random(love.graphics.getHeight()), 
			math.random(11)-6, math.random(11)-6,
		0, 0)
	end
end

function createBody(x, y, dx, dy, bodyType, size)
	body = {}
	body.x = x
	body.y = y
	body.dx = dx
	body.dy = dy
	body.bodyType = bodyType
	body.size = size
	return body
end

function updateBody(body)
	body.x = body.x + body.dx
	body.y = body.y + body.dy
end