--[[
Lua multimethods. Inspired by Clojure's multimethods.

How to use it:

    local Multi = require('multimethod')

    -- This simple example will dispatch on first argument by type.
    local foo = Multi.new(Multi.isa)

    -- Creating an implementation for a multimethod is easy... just assign
    -- a function to desired dispatch key.

    function foo.string(x)
      print("string!")
    end

    function foo.number(x)
      print("number!")
    end

    foo('what is this?')
]]--

local exports = {}

-- Create metatable for multimethods.
local Multi = {}

function Multi.__call(t, ...)
  -- Generate a key for arguments
  local k = t.__dispatch(...)
  -- Find the method for key (if any)
  local method = t[k]
  -- Invoke it with arguments
  return method(...)
end

-- Create a new multimethod.
-- It's up to you to provide a dispatch function that can generate a key
-- for a given set of arguments. If a method exists for that key, it will
-- be invoked for those arguments.
local function new(dispatch)
  -- Set dispatch function and metatable
  return setmetatable({__dispatch = dispatch}, Multi)
end
exports.new = new

-- A fast and simple way to flag different "types" of data.
-- These aren't true types, but they work well enough for Lua.
local function isa(x)
  -- If x is a table with a type field, return that as the key.
  if type(x) == 'table' and type(x.type) == 'string' then
    return x.type
  -- Otherwise return the actual type of the data (table, number, string, etc)
  else
    return type(x)
  end
end
exports.isa = isa

return exports