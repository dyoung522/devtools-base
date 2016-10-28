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
      let (:options) { RunTest::OptParse.parse([], true) }

      it "should have a valid --basedir command" do
        my_options = nil
        expect { my_options = RunTest::OptParse.parse(%w(--basedir foo), true) }.not_to raise_error
        expect(my_options.basedir).to eq("foo")
        expect(options.basedir).not_to be nil
      end

      it "should have a valid --changed command" do
        my_options = nil
        expect { my_options = RunTest::OptParse.parse(%w(--changed), true) }.not_to raise_error
        expect(my_options.changed).to be true # can be set
        expect(options.changed).to be false # defaults to false
      end

      it "should have a valid --jest command" do
        my_options = nil
        expect { my_options = RunTest::OptParse.parse(%w(--jest), true) }.not_to raise_error
        expect(my_options.jest).to be true # can be set
        expect(RunTest::OptParse.parse(%w(--no-jest), true).jest).to be false # can be unset
        expect(options.jest).to be true # defaults to false
      end

      it "should have a valid --mocha command" do
        my_options = nil
        expect { my_options = RunTest::OptParse.parse(%w(--mocha), true) }.not_to raise_error
        expect(my_options.mocha).to be true # can be set
        expect(RunTest::OptParse.parse(%w(--no-mocha), true).mocha).to be false # can be unset
        expect(options.mocha).to be true # defaults to false
      end

      it "should have a valid --diff-cmd command" do
        my_options = nil
        expect { my_options = RunTest::OptParse.parse(%w(--diff-cmd foo), true) }.not_to raise_error
        expect(my_options.commands.diff).to eq("foo")
        expect(options.commands.diff).not_to be nil
      end

      it "should have a valid --jest-cmd command" do
        my_options = nil
        expect { my_options = RunTest::OptParse.parse(%w(--jest-cmd foo), true) }.not_to raise_error
        expect(my_options.commands.jest).to eq("foo")
        expect(options.commands.jest).not_to be nil
      end

      it "should have a valid --mocha-cmd command" do
        my_options = nil
        expect { my_options = RunTest::OptParse.parse(%w(--mocha-cmd foo), true) }.not_to raise_error
        expect(my_options.commands.mocha).to eq("foo")
        expect(options.commands.mocha).not_to be nil
      end
    end
  end
end
