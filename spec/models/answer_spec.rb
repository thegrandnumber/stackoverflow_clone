require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "#associations" do
    it {should belong_to :question}
  end  

  context "validations" do
    it "is valid with title and content" do
      answer = Answer.new(title: "a full title", content: "a broad answer")
      expect(answer).to be_valid
    end

    it "is invalid without title" do
      answer = Answer.new( content: "a broad answer")
      expect(answer).to_not be_valid
    end

    it "is invalid without content" do
      answer = Answer.new(title: "a full title")
      expect(answer).to_not be_valid
    end

    it "is invalid with short title less than 6 chars" do
      answer = Answer.new(title: "ans", content: "a broad answer")
      expect(answer).to_not be_valid
    end
  end

  context "meta test from FactoryGirl" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:question)).to be_valid
    end
  end
end
