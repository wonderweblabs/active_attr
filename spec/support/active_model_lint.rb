require "active_model/lint"

shared_examples_for "ActiveModel" do
  include ActiveModel::Lint::Tests

  begin
    begin
      require "minitest/assertions"
    rescue LoadError
      require "minitest/unit"
    end

    include Minitest::Assertions

    attr_writer :assertions

    def assertions
      @assertions ||= 0
    end
  rescue LoadError
    require "test/unit/assertions"
    include Test::Unit::Assertions
  end

  before { @model = subject }

  ActiveModel::Lint::Tests.public_instance_methods.map(&:to_s).grep(/^test/).each do |test|
    example test.gsub("_", " ") do
      send test
    end
  end
end
