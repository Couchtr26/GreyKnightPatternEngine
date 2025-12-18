GreyKnight Pattern Engine

Author: Thomas Couch  
Version: 1.0  

---

Overview

**GreyKnight Pattern Engine** is a modular Ruby framework for building **reflex-based, FizzBuzz-style games**.  
It allows developers to define **custom themes and rules** while leveraging a **shared engine** for timing, scoring, round progression, and input validation.

This project demonstrates:

- Modular OOP design
- Real-time input handling and event coordination  
- Creative problem-solving and systems-level coding  
- The ability to invent novel interactive mechanics  

---

Features

- Core engine handles:
  - Rounds, lives, and scoring
  - Timed input with reaction windows
  - Automatic difficulty scaling
  - Score saving to JSON
- Multiple themes possible without changing core logic:
  - Bartender FizzBuzz
  - FizzBuzz Kitchen
  - FizzBuzz Climb
  - FizzBuzz Dive
- Easily extendable for new reflex or rhythm-based games

---

Installation

Clone the repository:

```bash
git clone https://github.com/Couchtr26/GreyKnightPatternEngine.git
cd GreyKnightPatternEngine

Run theme

ruby Dive_loader.rb
ruby Climb_loader.rb


