require "cascade/columns_matching"
require "cascade/cascade_csv"
require "cascade/row_processor"
require "cascade/error_handler"
require "cascade/helpers/hash"

module Cascade
  class DataParser
    def initialize(filename, options = {})
      @filename = filename
      @data_provider    = options.fetch(:data_provider)    { CascadeCsv }
      @row_processor    = options.fetch(:row_processor)    { RowProcessor.new }
      @error_handler    = options.fetch(:error_handler)    { ErrorHandler.new }
      @data_saver       = options.fetch(:data_saver)
    end

    # Starts parsing processing with opening file and iterating through each
    # line with parsing and then saves result of each line parsing with
    # DataSaver
    #
    def call
      @data_provider.open(@filename).each do |row|
        @error_handler.with_errors_handling(row) do
          @data_saver.call @row_processor.call(row)
        end
      end
    end
  end
end