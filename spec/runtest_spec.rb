require "spec_helper"
require "runtest"

module RunTest
  describe RunTest do
    it "has a version number" do
      expect(RunTest::VERSION).not_to be nil
    end

    it "has a program name" do
      expect(RunTest::PROGRAM_NAME).not_to be nil
    end

    describe OptParse do
      let (:options) { OptParse.parse([], true) }

      before :each do
        @option = {}
      end

      it "should have a valid --build command" do
        expect { OptParse.parse(%w(--build), true) }.not_to raise_error
        expect(OptParse.parse(%w(--build), true).build).to be true # can be set
        expect(OptParse.parse(%w(--no-build), true).build).to be false # can be unset
        expect(options.build).to be false # defaults to false
      end

      it "should have a valid --build-cmd command" do
        expect { @option = OptParse.parse(%w(--build-cmd foo), true) }.not_to raise_error
        expect(@option.cmd[:build]).to eq("foo") # can be set
        expect(options.cmd[:build]).not_to be nil
      end

      it "should have a valid --dry-run command" do
        expect { OptParse.parse(%w(--dry-run), true) }.not_to raise_error
        expect(OptParse.parse(%w(--dry-run), true).dryrun).to be true # can be set
        expect(options.dryrun).to be false # defaults to false
      end

      it "should have a valid --package command" do
        expect { OptParse.parse(%w(--package), true) }.not_to raise_error
        expect(OptParse.parse(%w(--package), true).package).to be true # can be set
        expect(OptParse.parse(%w(--no-package), true).package).to be false # can be unset
        expect(options.package).to be false # defaults to false
      end

      it "should have a valid --package-cmd command" do
        expect { @option = OptParse.parse(%w(--package-cmd foo), true) }.not_to raise_error
        expect(@option.cmd[:package]).to eq("foo") # can be set
        expect(options.cmd[:package]).not_to be nil
      end

      it "should have a valid --run command" do
        expect { OptParse.parse(%w(--run), true) }.not_to raise_error
        expect(OptParse.parse(%w(--run), true).run).to be true # can be set
        expect(OptParse.parse(%w(--no-run), true).run).to be false # can be unset
        expect(options.run).to be true # defaults to true
      end

      it "should have a valid --run-cmd command" do
        expect { @option = OptParse.parse(%w(--run-cmd foo), true) }.not_to raise_error
        expect(@option.cmd[:run]).to eq("foo") # can be set
        expect(options.cmd[:run]).not_to be nil
      end

      it "should have a valid --help command" do
        expect { OptParse.parse(%w(--help), true) }.not_to raise_error
      end

      it "should have a valid --verbose command" do
        expect { @option = OptParse.parse(%w(--verbose --verbose), true) }.not_to raise_error
        expect(@option.verbose).to eq(2)
        expect(options.verbose > 0).to be true
      end

      it "should have a valid --version command" do
        expect { OptParse.parse(%w(--version), true) }.not_to raise_error
      end
    end
  end
end
