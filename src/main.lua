ROCK = 1
SHIP = 2
		
WHITE = { red=255, green=255, blue=255, alpha=255}
GREEN = { red=0, green=255, blue=0, alpha=255}

debugship = false;

function love.draw()
	love.graphics.print("SPACEGAME", 400, 400)
  if debugship then
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(string.format("x %d y %d angle %f thrust %f dx %f dy %f dangle %f", ship.x, ship.y, ship.angle, ship.thrust, ship.dx, ship.dy, ship.dr), 0, 0)
  end
  
	for i,body in ipairs(bodies) do
		if body.image ~= nil then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(body.image, body.x, body.y, body.angle, 1  , 1, body.image:getWidth() / 2, body.image:getHeight() / 2)
		end
    
    love.graphics.setColor(body.color.red, body.color.green, body.color.blue, body.color.alpha)
		if body.bodyType == ROCK then
			love.graphics.circle("fill", body.x, body.y, body.size)
		elseif (body.bodyType == SHIP) then
			love.graphics.circle("line", body.x, body.y, body.size, 32)
		end
	end
end

function love.update()	
	for i,body in ipairs(bodies) do 
		updateBody(body)
	end
	detectCollisions()
end

function love.load()

	-- testloader()
	normalloader()

end

function testloader()
	bodies = {}

	bodies[1] = createBody(100, 0, 0, 0, ROCK, 50, WHITE )
	bodies[2] = createBody(150, 0, 0, 0, ROCK, 50, WHITE )
--	bodies[3] = createBody(300, 0, 1, 0, ROCK, 50, GREEN ) */
end

function normalloader()

	bodies = {}
  local rockCount = 11
	for i=1,rockCount do
		bodies[i] = createRock()
	end
	ship = createShip()
  bodies[rockCount+1] = ship
	ship.image = love.graphics.newImage("ship.png");
	ship.size = ship.image:getWidth() / 2;
end

function createShip()
	return createBody(love.graphics.getWidth() / 2, 
		love.graphics.getHeight() / 2,	0, 0, SHIP, 10, {red=255, green=255, blue=255, alpha=127})
end

function createRock()
	return createBody(math.random(love.graphics.getWidth()), 
		math.random(love.graphics.getHeight()), 
		createRandom(), createRandom(),
	ROCK, 20, {red=255, green=255, blue=255, alpha=127})
end

function createBody(x, y, dx, dy, bodyType, size, color)
	body = {}
	body.x = x
	body.y = y
	body.dx = dx
	body.dy = dy
	body.bodyType = bodyType
	body.size = size
	body.color = color
	body.dr = 0;
	body.angle = 0
	body.thrust = 0;
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
  body.dx = body.dx + math.cos(body.angle) * body.thrust;
  body.dy = body.dy + math.sin(body.angle) * body.thrust;
  
	body.x = body.x + body.dx
	body.y = body.y + body.dy
	body.angle = body.angle + body.dr;
	if body.x <= body.size then
		body.dx = -body.dx
	end
	if body.x >= love.graphics.getWidth() - body.size then
		body.dx = -body.dx
	end
		if body.y <= body.size then
		body.dy = -body.dy
	end
	if body.y >= love.graphics.getHeight() - body.size then
		body.dy = -body.dy
	end
end

function love.keypressed(key, unicode)
	if key == 'q' then
		love.event.push("quit")
	elseif key == 'e' then
		ship.dx = 0
		ship.dy = 0
    ship.thrust = 0
    ship.dr = 0
    ship.angle = 0
    ship.x = love.graphics.getWidth() / 2;
    ship.y = love.graphics.getHeight() / 2;
  elseif key == '.' then
    debugship = not debugship
  elseif key == "up" then
    ship.thrust = ship.thrust + 0.1
  elseif key == "right" then
    ship.dr = math.min(ship.dr + 0.01, 0.02)
  elseif key == "left" then
    ship.dr = math.max(ship.dr - 0.01, -0.02)
	end
end

function detectCollisions()
	for i,body1 in ipairs(bodies) do
		for j,body2 in ipairs(bodies) do
			if i ~= j then
				if hasCollided(body1, body2) then
					body1.color = {red = math.random(255), green = math.random(255), blue = math.random(255), alpha = body1.color.alpha}
					body2.color = {red = math.random(255), green = math.random(255), blue = math.random(255), alpha = body2.color.alpha}
--					print(body1.color.red, body1.color.green, body1.color.blue)
--					print(body2.color.red, body2.color.green, body2.color.blue)
				end
			end
		end
	end
end

function hasCollided(body1, body2)
	local distanceX = body1.x - body2.x
	local distanceY = body1.y - body2.y
	local collisionDistance = body1.size + body2.size
	local collision = (distanceX * distanceX + distanceY * distanceY) < (collisionDistance * collisionDistance)
--	print("body1", body1.x, body1.y, body1.size)
--	print("body2", body2.x, body2.y, body2.size)
--	print("collisionDistance", collisionDistance)
--	print("dx", distanceX)
--	print("dy", distanceY)
--	print("dx2 + dy2", distanceX * distanceX + distanceY * distanceY)
--	print("collisionDistance2", collisionDistance * collisionDistance)
--	print("collided", collision )
	return collision;
end
	