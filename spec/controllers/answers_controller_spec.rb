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

  describe 'PUT #update' do
    it "should update the answer" do
      put :update, question_id: @question.id, id: @answer.id, answer: {title: "Updated Testing answer", content: "tested answer"}
      expect(Answer.find(@answer.id).title).to eq("Updated Testing answer")
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @question = FactoryGirl.create(:question)
      @answer = FactoryGirl.create(:answer)
      @question.answers << @answer
    end

    it "deletes the question" do
      expect{
      delete :destroy, id: @answer, question_id: @question}.to change(Answer, :count).by(-1)
    end

    it 'redirects to question show page' do
      delete :destroy, id: @answer, question_id: @question
      expect(response).to redirect_to question_url(@question)
    end
  end

  describe 'POST #upvote' do
    before(:each) do
      @question = FactoryGirl.create(:question)
      @answer = @question.answers.create(FactoryGirl.attributes_for(:answer))
    end

    it "adds a vote to the vote count" do
    post :upvote, question_id: @question.id, id: @answer
    (@answer).reload
    # Active Record Reload!!
    expect(@answer.vote_count).to eq(1)
    end

    it "redirects to the question page" do
    post :upvote, question_id: @question.id, id: @answer
    expect(response).to redirect_to(question_url(@question))
    end
  end

  describe 'POST #downvote' do
    before(:each) do
      @question = FactoryGirl.create(:question)
      @answer = @question.answers.create(FactoryGirl.attributes_for(:answer))
    end

    it "subtracts a vote from the vote count" do
    post :upvote, question_id: @question.id, id: @answer
    post :downvote, question_id: @question.id, id: @answer

    (@answer).reload
    # Active Record Reload!!
    expect(@answer.vote_count).to eq(0)
    end

    it "redirects to the question page" do
    post :upvote, question_id: @question.id, id: @answer
    expect(response).to redirect_to(question_url(@question))
    end
  end


end
