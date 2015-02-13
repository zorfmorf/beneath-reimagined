--[[
    
    A civ-like message system where new messages are kept until
     - dismissed by player
     - new turn
    
]]--


-- message stack
local stack = {}
local show_id = nil


-- create a new message and put it on the stack
-- params: img=img, title=title, mssg=mssg
local function new(params)
    if params.title and params.mssg then
        table.insert(stack, params)
    end
end


-- remove the message with the given id or the opened message
local function dismiss(id)
    if id and stack[id] then 
        table.remove(stack, id)
        if show_id == id then show_id = nil end
    else
        stack[show_id] = nil
        show_id = nil
    end
end


-- remove all messages
local function dismiss_all()
    stack = {}
    show_id = nil
end


-- display the specified message
local function show(id)
    if stack[id] then show_id = id end
end


-- returns the currently displayed message or nil 
local function getDisplay()
    if show_id and stack[show_id] then return stack[show_id] end
    return nil
end


-- gives the amount of messages
local function count()
    return #stack
end


-- One could argue that it would be nice to just return the whole stack but in this way we can
-- assert no improper handling of the stack queue and no lost messages
-- Actually not important as I am the only one working on this project and even if we lost messages
-- its a fucking video game so who cares? Jesus christ.
local function get(id)
    return stack[id]
end


return {
    new = new,
    dismiss = dismiss,
    show = show,
    getDisplay = getDisplay,
    get = get,
    count = count,
    dismiss_all = dismiss_all
}