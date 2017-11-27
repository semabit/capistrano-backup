require "spec_helper"

RSpec.describe Capistrano::Backup do
  it "has a version number" do
    expect(Capistrano::Backup::VERSION).not_to be nil
  end
end
