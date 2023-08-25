require(love.filesystem.load("conf.lua")()
require("conf")

local function rgb(r,g,b)
  return {r/255, g/255, b/255}
end

local player = {
  x=WIDTH/2,
  y=HEIGHT/2,
  r=20,
  vy = 0,
  jump = false
}

--gerando os canos do jogo
local function pipe()
  return{
    x = WIDTH + 100,
    y = math.random(1/3 * HEIGHT, 2/3 * HEIGHT),
    esp = 200,
    comp = 80,
  }
end

local pipes = {}


local GRAVITY = 701

function love.load()
  
end

local pipeTimer = 2 * 60

function love.update()
  if pipeTimer == 0 then
    pipeTimer = 2 * 60
    table.insert(pipes, pipe())
  end
  pipeTimer = pipeTimer - 1

  for _, p in ipairs(pipes) do
    p.x = p.x - (1/2)*WIDTH/60
  end
  --jeito mais difícil !!!!

  -- if love.keyboard.isDown("space")then
  --   if not player.jump then
  --     player.vy = -500
  --     player.jump = true
  --   end
  -- else
  --   player.jump = false
  -- end

  player.y = player.y + player.vy/60
  player.vy= player.vy + GRAVITY/60
end

--jeito mais fácil !!!!
function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end

  if key == "space" then
    player.vy = -300
  end
end

function love.draw()
  love.graphics.clear(rgb(3, 194, 252))
  love.graphics.setColor(rgb(222, 123, 11))
  love.graphics.circle("fill", player.x, player.y, player.r)
--temporizador para gerar os canos
  for _, p in ipairs(pipes) do
    love.graphics.setColor(rgb(31, 156, 20))
    love.graphics.rectangle("fill", p.x - p.comp/2, 0, p.comp, p.y - p.esp/2)
    love.graphics.rectangle("fill", p.x - p.comp/2, p.y + p.esp/2, p.comp, HEIGHT - p.y - p.esp/2)
  end

  -- love.graphics.setColor(rgb(31, 156, 20))
  -- love.graphics.rectangle("fill", p.x - p.comp/2, 0, p.comp, HEIGHT - p.y - p.esp/2)
  -- love.graphics.rectangle("fill", p.x - p.comp/2, p.y + p.esp/2, p.comp, p.y - p.esp/2)
end

