local time = 0
local stars = {}

function love.load()
    love.graphics.setBackgroundColor(0.05, 0.05, 0.15)
    -- Generate starfield
    for i = 1, 100 do
        stars[i] = {
            x = love.math.random(0, 800),
            y = love.math.random(0, 600),
            size = love.math.random() * 2 + 0.5,
            speed = love.math.random() * 0.5 + 0.1
        }
    end
end

function love.update(dt)
    time = time + dt
    for _, star in ipairs(stars) do
        star.y = star.y + star.speed
        if star.y > 600 then
            star.y = 0
            star.x = love.math.random(0, 800)
        end
    end
end

function love.draw()
    -- Draw stars
    for _, star in ipairs(stars) do
        local alpha = 0.5 + 0.5 * math.sin(time * 2 + star.x)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.circle("fill", star.x, star.y, star.size)
    end

    -- Draw warrior silhouette (simple shield + sword figure)
    local cx, cy = 400, 300
    local bob = math.sin(time * 2) * 5

    -- Glow effect
    local glow = 0.5 + 0.3 * math.sin(time * 1.5)
    love.graphics.setColor(0.8, 0.4, 0.1, glow * 0.3)
    love.graphics.circle("fill", cx, cy + bob, 80)

    -- Body
    love.graphics.setColor(0.9, 0.6, 0.2)
    love.graphics.circle("fill", cx, cy - 40 + bob, 20) -- head
    love.graphics.setLineWidth(4)
    love.graphics.line(cx, cy - 20 + bob, cx, cy + 30 + bob) -- torso
    love.graphics.line(cx, cy + 30 + bob, cx - 20, cy + 60 + bob) -- left leg
    love.graphics.line(cx, cy + 30 + bob, cx + 20, cy + 60 + bob) -- right leg

    -- Shield (left arm)
    love.graphics.setColor(0.3, 0.5, 0.9)
    love.graphics.line(cx, cy + bob, cx - 30, cy + 10 + bob)
    love.graphics.rectangle("fill", cx - 45, cy - 5 + bob, 20, 30, 3, 3)

    -- Sword (right arm)
    love.graphics.setColor(0.9, 0.9, 0.9)
    love.graphics.line(cx, cy + bob, cx + 30, cy - 10 + bob)
    love.graphics.setLineWidth(3)
    love.graphics.line(cx + 30, cy - 10 + bob, cx + 55, cy - 35 + bob) -- blade
    love.graphics.setColor(0.8, 0.6, 0.1)
    love.graphics.rectangle("fill", cx + 26, cy - 14 + bob, 8, 4) -- crossguard

    -- Title
    love.graphics.setColor(1, 0.85, 0.3)
    local title = "CARRY WARRIOR"
    love.graphics.printf(title, 0, 150 + math.sin(time) * 3, 800, "center")

    -- Subtitle
    love.graphics.setColor(0.7, 0.7, 0.8, 0.6 + 0.4 * math.sin(time * 3))
    love.graphics.printf("Press any key to begin your journey...", 0, 450, 800, "center")
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
