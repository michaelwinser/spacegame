ROCK = 1
SHIP = 2
		
function love.draw()
	love.graphics.print("SPACEGAME", 400, 400)
	for i,body in ipairs(bodies) do
		if body.bodyType == ROCK then
			love.graphics.circle("line", body.x, body.y, 10)
		else
			love.graphics.circle("fill", body.x, body.y, 10)
		end
	end
end

function love.update()
	
	if love.keyboard.isDown('w') then
		ship.dy = ship.dy - 0.1
	elseif love.keyboard.isDown('a') then
		ship.dx = ship.dx - 0.1
	elseif love.keyboard.isDown('s') then
		ship.dy = ship.dy + 0.1
	elseif love.keyboard.isDown('d') then
		ship.dx = ship.dx + 0.1
	end
	
	for i,body in ipairs(bodies) do 
		updateBody(body)
	end
end

function love.load()
	bodies = {}
	for i=1,10 do
		bodies[i] = createRock()
	end
	bodies[11]=createShip()
	ship = bodies[11]
end

function createShip()
	return createBody(love.graphics.getWidth() / 2, 
		love.graphics.getHeight() / 2,
	0, 0, SHIP, 0)
end

function createRock()
	return createBody(math.random(love.graphics.getWidth()), 
		math.random(love.graphics.getHeight()), 
		createRandom(), createRandom(),
	ROCK, 0)
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

function createRandom ()
	local randNum=0
	while (randNum==0) do
		randNum=math.random(11)-6
	end
	return randNum
end

function updateBody(body)
	body.x = body.x + body.dx
	body.y = body.y + body.dy
	if body.x <= 0 then
		body.dx = -body.dx
	end
	if body.x >= love.graphics.getWidth() then
		body.dx = -body.dx
	end
		if body.y <= 0 then
		body.dy = -body.dy
	end
	if body.y >= love.graphics.getHeight() then
		body.dy = -body.dy
	end	
end

function love.keypressed(key, unicode)
	if key == 'q' then
		love.event.push("quit")
	elseif key == 'e' then
		ship.dx = 0
		ship.dy = 0
	end
end