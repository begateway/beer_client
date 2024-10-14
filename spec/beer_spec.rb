# frozen_string_literal: true

RSpec.describe Beer do
  it "has a version number" do
    expect(Beer::VERSION).not_to be nil
  end
end
