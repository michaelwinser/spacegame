function love.load()
   hamster = love.graphics.newImage("ship.png")
   width = hamster:getWidth()
   height = hamster:getHeight()   
   x = 0
   y = 0
   angle = 0;
   fthrust = 0;
   rthrust = 0;
   dx = 0
   dy = 0
   dangle = 0;
end

function love.update()

  if love.keyboard.isDown("w") then
    fthrust = 0.1
  else
    fthrust = 0;
  end

  if love.keyboard.isDown("d") then
--    rthrust = 0.005
    dangle = 0.05
  elseif love.keyboard.isDown("a") then
--    rthrust = -0.005
    dangle = -0.05
  else
--    rthrust = 0
    dangle = 0
  end

  fthrust = math.max(math.min(fthrust, 2), 0)
  rthrust = math.max(math.min(rthrust, 0.01), -0.01)

  dangle = dangle + rthrust

  dx = dx + fthrust * math.cos(angle)
  dy = dy + fthrust * math.sin(angle)

  x = x + dx
  y = y + dy
  angle = angle + dangle
end

function love.draw()
  love.graphics.print(string.format("x %d y %d angle %f fthrust %f rthrust %f dx %f dy %f dangle %f", x, y, angle, fthrust, rthrust, dx, dy, dangle), 0, 0)
  love.graphics.push();
  love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  love.graphics.draw(hamster, x, y, angle, 1, 1, width / 2, height / 2, angle)
  love.graphics.circle("line", x, y, 20)
  love.graphics.line(x, y, x + dx, y + dy)
  love.graphics.pop()
end
