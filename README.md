# Multimethod

Multimethod brings multiple dispatch functions to Lua (https://en.wikipedia.org/wiki/Multiple_dispatch).

Multimethods give you late-binding runtime polymorphism... in other words, you can implement multiple versions of the same function for different combinations of arguments.

Inspired by Clojure's approach (http://clojure.org/multimethods), a multimethod is a combination of a dispatching function, and one or more methods. The dispatching function gets to choose who gets called and in what circumstance. This is extremely flexible: you can dispatch on any feature or combination of features that you can derive from the arguments.

How to use it:

```lua
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
```