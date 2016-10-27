require "spec_helper"
require "devtools"

describe DevTools do
  it "has a version number" do
    expect(DevTools::VERSION).not_to be nil
  end

  it "has a program name" do
    expect(DevTools::PROGRAM).not_to be nil
  end
end
