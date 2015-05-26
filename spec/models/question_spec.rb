require 'rails_helper'

RSpec.describe Question, type: :model do
  context "#associations" do
    it {should have_many :answers}
  end

  context "validations" do
    it "is valid with title and content" do
      question = Question.new(title: "a full title", content: "a broad question")
      expect(question).to be_valid
    end

    it "is invalid without title" do
      question = Question.new( content: "a broad question")
      expect(question).to_not be_valid
    end

    it "is invalid without content" do
      question = Question.new(title: "a full title")
      expect(question).to_not be_valid
    end

    it "is invalid with short title less than 6 chars" do
      question = Question.new(title: "que", content: "a broad question")
      expect(question).to_not be_valid
    end

    it "is invalid with duplicate title" do
      question1 = Question.new(title: "question", content: "a broad question")
      question1.save
      question2 = Question.new(title: "question", content: "a broad question")
      expect(question2).to_not be_valid
    end
  end

  context "meta tests - ie factoryGirl set up even tho only use in controller" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:question)).to be_valid
    end

  end
end
