module Sudoku
  class Coordinates

    attr_accessor :row, :column

    def initialize(row: 0, column: 0, increment_on_init: false)
      @row = row
      @column = column
      increment! if increment_on_init
    end

    def increment!
      @column += 1
      if @column == 9
        @column = 0
        @row += 1
      end
    end

    def to_a
      [@row, @column]
    end

  end
end