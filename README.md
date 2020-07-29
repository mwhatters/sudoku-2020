# sudoku-2020
sudoku-2020

A remake of a remake of a remake for a sudoku solver. I do this every once in a while to track my progress on how I organize code.

from the root directory of the project, run:

```bash
irb -r ./game.rb
```

then, in the session:
```ruby
game = Sudoku::Game.new(random: true, density: 0.1)
game.solve

# random: bool -- generates a random board
# density: float -- determines how densely filled a random board should be. Only works when random is true

game = Sudoku::Game.new(random: true, density: 0.1)
game.display
# [0, 0, 0, 0, 0, 0, 0, 0, 0]
# [1, 0, 0, 0, 6, 0, 0, 0, 0]
# [5, 0, 0, 0, 0, 0, 0, 0, 0]
# [2, 0, 0, 0, 5, 0, 0, 0, 0]
# [0, 0, 0, 0, 0, 0, 0, 0, 0]
# [7, 0, 9, 2, 0, 0, 0, 0, 0]
# [0, 0, 0, 0, 0, 0, 9, 0, 0]
# [0, 0, 2, 0, 0, 0, 0, 0, 0]
# [9, 0, 0, 0, 0, 0, 0, 0, 0]
```

This shows an improvement from the previous iteration of this project in a number of ways:

1. Responsibilities are more clearly divided and class size is reduced. We have a primary class responsible for generating the sudoku board. We have a solver class which implements the solving algorithm for the game. The validator has a single responsibility of checking the state of the game, determining if the numbers placed are valid, and if the game is complete. The coordinates class is a simple class that tracks positions on the board.

2. In the previous iteration of this solver, we dealt with multiple data structures in solving and validating the game. When solving, the 2d array was converted into a string of numbers, and then iterated through. The validator, however, checked the validity of the board in its original 2d array state. This constant interchanging between data structures made the code more difficult to parse. In this version, only a single data structure is used to represent the game board, and is shared amongst every class.

3. Naming is generally better. A random board generator is also included, which includes a density mechanic (for more difficult or easier boards)

4. No longer are objects duped across recursive function calls, which should reduce memory overhead.

Some things to address:

1. The algorithm is largely unchanged. It's a recursive algorithm that essentially brute-forces the solution. For more difficult boards this can take quite some time to solve. Even performing simple checks on the board before beginning to brute-force it could drastically reduce the number of moves required to solve a board.