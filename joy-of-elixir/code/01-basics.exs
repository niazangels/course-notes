# Functions
greeting = fn (name, loc) -> "Hello, #{name}! I see you are from #{loc}" end

# Capture operator
greeting = &("Hello, #{&1}! I see you are from #{&2}")

greeting.("Niyas", "Panama")

# Maps (won't keep order)
p1 = %{"name" => "Niyas", "age" => 16}
p1 = %{:name => "Niyas", :age => 16}
p1 = %{name: "Niyas", age: 16}

# The following won't work- even the syntax highlighting is different
# p1 = %{name : "Niyas", age : 16}


p1 = %{name: "Niyas", age: 16}
p2 = %{name: "Raj", age: 14}

average_age = fn(p1, p2) -> ((p1.age + p2.age) / 2) end
average_age = fn(p1, p2) -> (p1.age/2 + p2.age/2) end
average_age.(p1, p2)

# The equals sign isn't just about assigning things to make the computer remember them, but it can also be used for matching things. 
"dog" = "dog"
4 = 2 + 2

# The following will raise a match error
# 5 = 2 + 2

# Pattern matching with lists
those_who_are_assembled = [
 %{age: "30ish", gender: "Female", name: "Izzy"},
 %{age: "30ish", gender: "Male", name: "The Author"},
 %{age: "56", gender: "Male", name: "Roberto"},
 %{age: "38", gender: "Female", name: "Juliet"},
 %{age: "21", gender: "Female", name: "Mary"},
 %{age: "67", gender: "Female", name: "Bobalina"},
 %{age: "54", gender: "Male", name: "Charlie"},
 %{age: "10", gender: "Male", name: "Charlie (no relation)"},
]
[first, second, third | others] = those_who_are_assembled


# Pattern matching with maps
p1 = %{name: "Niyas", age: 16}
%{name: fname, age: years} = p1 # `fname` and `years` will now hold the correct values


# Combining map and list pattern matching
[%{name: first_name} | others] = those_who_are_assembled


# Take it even further by naming the matched pattern
[first_person = %{name: first_name} | others] = those_who_are_assembled
# [first_name, first_person ]


# Pattern matching inside functions
road = fn
    "high" -> "You take the high road" # This is called a `clause`
    "low" -> "And I'll tkae the low road! (And I'll get there before you!)"
end
# road.("high")
# road.("middle") -> FunctionClauseError


# Pattern matching maps inside fns
greeting = fn
    %{name: fname} -> "Hello #{fname}!"
    %{} -> "Anonymous"
end
# greeting.(%{})
# greeting.(%{name: "Niyas"})

# However:
# greeting.(%{age: "30ish"}) -> "Hello, Anonymous Stranger!"
# This is because in Elixir when you match two maps together it will always match on subset of the map. The left-hand-side showing the keys that are absolutely required for the match to work. The right-hand-side must contain the same keys as the left-hand-side, but the right-hand-side can contain more keys than what's on the left. 

%{} = %{name: "Izzy"} # -> %{"name" => "Izzy"}

# In the first clause's case, it will only match if the argument passed to the greeting function is a map which contains a "name" key; this key is required by the match. If the map does not contain a "name" key then this clause will not match. The second clause matches any map, and so that is the clause that will be used for any map not containing a "name" key. 


# Match anything
road = fn
  "high" -> "You take the high road!"
  "low" -> "I'll take the low road! (and I'll get there before you)"
  _ -> "Take the 'high' road or the 'low' road, thanks!"
end
# road.("middle")


# Working with strings

# Reversing a string
String.reverse("This car is in reverse!")
String.reverse "This car is in reverse!"

# Wait a second, why doesn't that need a `.` between the fn and the args??


