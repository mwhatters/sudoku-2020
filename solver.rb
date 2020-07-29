require_relative './game.rb'
require_relative './coordinates.rb'

module Sudoku
  module Solver

    def self.solve(game: Sudoku::Game.new, display: false, row: 0, column: 0)
      game.total_moves_performed += 1
      current_row = row
      current_column = column
      next_step = Sudoku::Coordinates.new(row: current_row, column: current_column, increment_on_init: true)
      
      while game.given_number_coordinates.include?(next_step.to_a)
        next_step.increment!
      end

      sudoku_number = 1
      while sudoku_number < 10
        game.board[current_row][current_column] = sudoku_number

        if game.valid?
          game.display if display
          return game if game.complete?
          return true if self.solve(
            game: game,
            display: display,
            row: next_step.row,
            column: next_step.column,
          )
        end

        sudoku_number += 1
      end

      game.board[current_row][current_column] = nil
      false
    end

  end
end