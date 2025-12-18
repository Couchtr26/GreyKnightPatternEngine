
require_relative "pattern_engine"
include GreyKnightCore

theme = {
  title: "FizzBuzz Climb",
  instructions: "Swing on 2, Jump on 5, and Swing+Jump on 10! Hold on tight!",
  actions: {
    2 => "swing",
    5 => "jump",
    10 => "swing jump"
  }
}

game = PatternEngine.new(theme: theme)
game.start
