require "spec_helper"
require "qa_queue"

module QAqueue
  describe QAqueue do
    it "has a VERSION" do
      expect(VERSION).not_to be nil
    end

    it "has an IDENT" do
      expect(IDENT).not_to be nil
    end

    xdescribe OptParse do
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

    end
  end
end
