require_relative './solver.rb'
require_relative './validator.rb'
require 'pry'

module Sudoku
  class Game

    attr_accessor :board, :given_number_coordinates, :moves_until_complete
    attr_reader :density

    def initialize(board: nil, random: false, density: 0.3)
      @given_number_coordinates = []
      @moves_until_complete = 0
      @density = density
      @board = if !board
        random ? new_random : new_empty
      else
        board
      end

      collect_given_number_coordinates
    end

    def solve(display: true)
      Sudoku::Solver.solve(game: self, display: display)
    end

    def valid?
      Sudoku::Validator.new(board: self.board).valid?
    end

    def complete?
      Sudoku::Validator.new(board: self.board).complete?
    end

    def regenerate(density: 0.3)
      @density = density
      new_random
      collect_given_number_coordinates
    end

    def display
      system('clear')
      board.each do |row|
        displayed_row = row.map { |v| v.nil? ? 0 : v }
        p displayed_row
      end
      nil
    end

    private def new_random
      # generate a random board, then selectively remove elements based on density. 
      @board = new_empty
      @board[0] = (1..9).to_a.shuffle
      Sudoku::Solver.solve(game: self, display: false)

      @board.each do |row|
        row.each_with_index do |val,idx|
          if rand(0.0..1.0) > density
            row[idx] = nil
          end
        end
      end
    end

    private def new_empty
      @board = Array.new(9) { Array.new(9) }
    end

    private def collect_given_number_coordinates
      board.each_with_index do |row, row_index|
        row.each_with_index do |column, col_index|
          given_number_coordinates << [row_index, col_index] if !column.nil?
        end
      end
    end

  end
end