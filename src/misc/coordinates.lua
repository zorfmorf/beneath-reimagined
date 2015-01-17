
grid = {
    w = 64,
    h = 32,
    xs = 8,
    ys = 8
}

function convertToMap(x, y)
    local mx = math.floor((x / (grid.w * 0.5) + y / (grid.h * 0.5)) * 0.5)
    local my = math.floor((y / (grid.h * 0.5) - x / (grid.w * 0.5)) * 0.5)
    return mx, my
end

function convertToScreen(x, y)
    local sx = (x - y) * grid.w * 0.5
    local sy = (x + y) * grid.h * 0.5
    return sx, sy
end