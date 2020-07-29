module Sudoku
  class Validator

    attr_reader :board

    def initialize(board:)
      @board = board
    end

    def valid?
      valid_columns && valid_rows && valid_square_segments
    end

    def complete?
      filled = board.all? do |row|
        row.all? { |val| !val.nil? }
      end

      filled && valid?
    end

    private def valid_columns
      board.transpose.all? do |column|
        no_dupes?(column)
      end
    end

    private def valid_rows
      board.all? do |row|
        no_dupes?(row)
      end
    end

    private def valid_square_segments
      SEGMENT_INDICES.all? do |x, y|
        square = []
        OPERATORS.each do |i, k|
          square << board[x+i][y+k]
        end

        no_dupes?(square)
      end
    end

    private def no_dupes?(array)
      filtered_array = array.select { |el| !el.nil? }
      filtered_array.uniq == filtered_array
    end

    SEGMENT_INDICES = [
      #  x, y
      [1, 1],
      [1, 4],
      [1, 7],
      [4, 1],
      [7, 1],
      [4, 4],
      [4, 7],
      [7, 4],
      [7, 7]
    ].freeze

    OPERATORS = [
      #  x, y
      [0,0],
      [0,1],
      [0,-1],
      [-1,-1],
      [1,-1],
      [1,1],
      [-1,1],
      [-1,0],
      [1,0],
    ].freeze

  end
end