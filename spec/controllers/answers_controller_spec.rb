require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  before :each do
    Question.delete_all
    @question = Question.create!(title: "testtitle", content: "content stuff")
    @answer = @question.answers.create(title: "Testing answer", content: "tested answer")
  end

  describe 'POST #create' do
    before :each do
      post :create, question_id: @question.id, answer: {title: "Testing answer", content: "tested answer"}
    end

    it "should create a new answer" do
      expect(Answer.last.title).to eq("Testing answer")
    end
  end
end
