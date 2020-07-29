require_relative './solver.rb'
require_relative './validator.rb'

module Sudoku
  class Game

    attr_accessor :board, :given_number_coordinates
    attr_reader :density

    def initialize(board: nil, random: false, density: 0.3)
      @given_number_coordinates = []
      @density = density
      @board = if !board
        random ? new_random : new_empty
      else
        board
      end

      collect_given_number_coordinates
    end

    def solve
      Sudoku::Solver.solve(game: self)
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
      @board = Array.new(9) { Array.new(9) }
      board.each do |row|
        row.each_with_index do |val,idx|
          nums = Array.new(9) { |i| i+1 }.shuffle!
          if rand(0.0..1.0) < density && val.nil?
            idx_ref = 0
            row[idx] = nums[idx_ref]
            until valid
              idx_ref += 1
              row[idx] = nums[idx_ref]
            end
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