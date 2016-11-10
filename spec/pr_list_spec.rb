require "spec_helper"
require "pr_list"

module DevTools
  module PRlist
    describe "PRlist" do
      it "has a VERSION" do
        expect(VERSION).not_to be nil
      end

      it "has an IDENT" do
        expect(IDENT).not_to be nil
      end

      describe OptParse do
        let (:options) { OptParse.parse([], true) }

        context "--queue" do
          it "should be valid" do
            my_options = nil

            expect { my_options = OptParse.parse(%w(--queue), true) }.not_to raise_error
            expect(my_options.queue).to be true # can be set
          end

          it "should be negatable" do
            my_options = nil

            expect { my_options = OptParse.parse(%w(--no-queue), true) }.not_to raise_error
            expect(my_options.queue).to be false # can be unset
          end

          it "should default to false" do
            expect(options.queue).to be false
          end
        end

      end

      describe PullRequest do
        let (:issue) { build(:issue) }
        let (:pull_request) { PullRequest.new issue }

        it "should have a valid date method" do
          expect(pull_request.date).not_to be nil
          expect(pull_request.date).to eq(issue.created_at)
        end

        it "should have a valid labels method" do
          expect(pull_request.labels).not_to be nil
          expect(pull_request.labels).to be_a(Array)
        end

        it "should have a valid number method" do
          expect(pull_request.number).not_to be nil
          expect(pull_request.number).to eq(issue.number)
        end

        it "should have a valid title method" do
          expect(pull_request.title).not_to be nil
          expect(pull_request.title).to eq(issue.title)
        end

        context "#repo" do
          it "should return the short repository name" do
            expect(pull_request.repo).to eq("baz-bat")
          end

          it "should return the full repository name when requested" do
            expect(pull_request.repo(true)).to eq("foobar/baz-bat")
          end
        end
      end
    end
  end
end

