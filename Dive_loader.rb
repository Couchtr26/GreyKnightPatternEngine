
require_relative "Pattern_Engine"
include GreyKnightCore

theme = {
  title: "FizzBuzz Dive",
  instructions: "Swim on 2, Dive on 5, and Swim+Dive on 10! Avoid drowning!",
  actions: {
    2 => "swim",
    5 => "dive",
    10 => "swim dive"
  }
}

game = PatternEngine.new(theme: theme)
game.start
