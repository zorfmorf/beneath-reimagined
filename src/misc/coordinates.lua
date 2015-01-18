
grid = {
    w = 128,
    h = 64,
    z = 78,
    xs = 8,
    ys = 8
}

function convertToMap(x, y, z)
    local mx = (x / (grid.w * 0.5) + y / (grid.h * 0.5)) * 0.5
    local my = (y / (grid.h * 0.5) - x / (grid.w * 0.5)) * 0.5
    return mx, my
end

function convertToScreen(x, y, z)
    local sx = (x - y) * grid.w * 0.5
    local sy = (x + y) * grid.h * 0.5 - z * grid.z
    return sx, sy
end