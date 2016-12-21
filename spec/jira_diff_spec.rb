require "spec_helper"
require "jira_diff"

module JIRADiff
  describe JIRADiff do
    it "has a version number" do
      expect(VERSION).not_to be nil
    end

    it "responds to run!" do
      expect(JIRADiff).to respond_to('run!')
    end

    describe OptParse do
      let (:options) { OptParse.parse([], true) }

      context "--master" do
        it "should be valid" do
          my_options = nil

          expect { my_options = OptParse.parse(%w(--master foo), true) }.not_to raise_error
          expect(my_options.master).to eq("foo")
        end

        it "should default to master" do
          expect(options.master).to eq("master")
        end
      end

      context "--source" do
        it "should be valid" do
          my_options = nil

          expect { my_options = OptParse.parse(%w(--source foo), true) }.not_to raise_error
          expect(my_options.source).to eq(%w(foo))
        end

        it "should default to develop" do
          expect(options.source).to eq(%w(develop))
        end

        it "should allow multiple values" do
          expect(OptParse.parse(%w(--source foo --source bar), true).source).to eq(%w(foo bar))
        end
      end

      context "--directory" do
        it "should be valid" do
          my_options = nil

          expect { my_options = OptParse.parse(%w(--directory spec), true) }.not_to raise_error
          expect(my_options.directory).to match("#{Dir.pwd}/spec")
        end

        it "should default to ." do
          expect(options.directory).to eq(".")
        end

        it "should require a valid directory" do
          expect { OptParse.parse(%w(--directory foo), true) }.to raise_error(ArgumentError)
        end
      end

     end
  end
end

