require "spec_helper"
require "devtools"

module DevTools
  describe DevTools do
    it "has a version number" do
      expect(VERSION).not_to be nil
    end

    it "has a program name" do
      expect(PROGRAM).not_to be nil
    end

    context OptParse do
      let (:options_parser) { OptParse.new({ name: "test", version: "0.0.0", testing: true }) }

      it "should have a valid --config command" do
        expect { options_parser.parser.parse(%w(--config spec/spec_config.yml)) }.not_to raise_error
        expect(Options.test_config).to be true
      end

      it "should have a valid --dryrun command" do
        expect(Options.dryrun).to be_falsey
        expect { options_parser.parser.parse(%w(--dry-run)) }.not_to raise_error
        expect(Options.dryrun).to be true
      end

      it "should have a valid --help command" do
        expect { options_parser.parser.parse(%w(--help)) }.not_to raise_error
      end

      it "should have a valid --verbose command" do
        expect(Options.verbose).to eq(0)
        expect { options_parser.parser.parse(%w(--verbose --verbose)) }.not_to raise_error
        expect(Options.verbose).to eq(2)
      end

      it "should have a valid --version command" do
        expect { options_parser.parser.parse(%w(--version)) }.not_to raise_error
      end
    end
  end
end
