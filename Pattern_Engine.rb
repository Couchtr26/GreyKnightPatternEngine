# === GreyKnight Core Pattern Engine ===
# Game logic for FizzBuzz-style reflex games.
# Version 1.0 by Thomas Couch / GreyKnightSoftware

require "timeout"
require "json"

module GreyKnightCore
  # Handling of timing, scoring, and round progression
  class PatternEngine
    attr_reader :score, :lives, :reaction_time, :round, :theme

    def initialize(theme:, lives: 3, reaction_time: 5.0)
      @theme = theme            # hash of divisible => action
      @score = 0
      @lives = lives
      @reaction_time = reaction_time
      @round = 1
    end

    def start
      puts "=== GreyKnight Reflex Engine ==="
      puts "Theme: #{@theme[:title]}"
      puts "Instructions: #{@theme[:instructions]}"
      puts "--------------------------------"

      loop do
        steps = generate_steps(@round)
        display_order(@round, steps)
        input = timed_input(@reaction_time)

        if input.nil?
          puts "⏱️  Too slow!"
          lose_life
          break if game_over?
          next
        end

        expected = steps.join(" ")
        if input.strip.downcase == expected
          handle_success(steps)
        else
          puts "❌ Wrong! Expected '#{expected}'"
          lose_life
          break if game_over?
        end

        @round += 1
      end

      puts "\nShift over! Final score: #{@score}"
      save_score
    end

    private

    def generate_steps(number)
      rules = @theme[:actions]
      steps = rules.keys.select { |k| number % k == 0 }.sort.map { |k| rules[k] }
      steps.empty? ? ["wait"] : steps
    end

    def display_order(num, steps)
      puts "\nOrder ##{num}: #{steps == ['wait'] ? 'Nothing this round' : steps.join(' → ').upcase}"
    end

    def timed_input(limit)
      input = nil
      begin
        Timeout.timeout(limit) do
          print "> "
          input = STDIN.gets&.strip
        end
      rescue Timeout::Error
        input = nil
      end
      input
    end

    def handle_success(steps)
      gained = steps.length * 3
      @score += gained
      puts "✅ Perfect! +#{gained} points. Total: #{@score}"
      speed_up_if_needed
    end

    def speed_up_if_needed
      if @score % 50 == 0
        @reaction_time = [@reaction_time - 0.2, 2].max
        puts "🔥 Rush hour! Reaction window: #{@reaction_time.round(1)}s"
      end
    end

    def lose_life
      @lives -= 1
      puts "❤️ Lives left: #{@lives}"
    end

    def game_over?
      @lives <= 0
    end

    def save_score
      file = "scores.json"
      scores = File.exist?(file) ? JSON.parse(File.read(file)) : []
      scores << { time: Time.now, score: @score, theme: @theme[:title] }
      File.write(file, JSON.pretty_generate(scores))
      puts "💾 Score saved to #{file}"
    end
  end
end
