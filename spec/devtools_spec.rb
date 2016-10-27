require "spec_helper"
require "devtools"

module DevTools
  describe DevTools do
    it "has a version number" do
      expect(DevTools::VERSION).not_to be nil
    end

    it "has a program name" do
      expect(DevTools::PROGRAM).not_to be nil
    end

    context Options do
      let (:options_parser) { DevTools::Options.new("test", "0.0.0", true) }

      it "should have a valid --help command" do
        expect { options_parser.parser.parse(%w(--help)) }.not_to raise_error
      end

      it "should have a valid --verbose command" do
        expect { options_parser.parser.parse(%w(--verbose --verbose)) }.not_to raise_error
        expect(options_parser.options.verbose).to eq(2)
        expect(options_parser.options.verbose > 0).to be true
      end

      it "should have a valid --version command" do
        expect { options_parser.parser.parse(%w(--version)) }.not_to raise_error
      end
    end
  end
end
