require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  before(:each) do
    Question.delete_all
  end
  # rspec transactional fixtures don't need the above unless capybara

  describe "GET #index" do
    before(:each) do
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the @questions instance variable' do
      expect(assigns :questions).to be_a(Question::ActiveRecord_Relation)
    end
  end

  describe "GET #show" do
    let(:question) { FactoryGirl.create :question}
    it "returns http success" do
      get :show, id: question.id
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested question to @question" do
      get :show, id: question.id
      expect(assigns :question).to eq(question)
    end

    it 'renders the #show page' do
      get :show, id: question.id
      expect(response).to render_template :show
    end
  end


  describe 'POST #create' do

    it "create accepts valid questions" do
      form = {title: "a long enough title", content: "also long content"}
      expect{
      post :create, {question: form}}.to change{Question.count}
    end

    it "redirects on valid creation" do
      form = {title: "a long enough title", content: "also long content"}
      post :create, {question: form}
      expect(response).to redirect_to question_url(Question.last)

    end

    it "create fails on missing title" do
      form = {title: nil, content: "also long content"}
      expect{
      post :create, {question: form}}.to_not change{Question.count}
    end

    it "create fails on missing content" do
      form = {title: "a long enough title", content: nil}
      expect{
      post :create, {question: form}}.to_not change{Question.count}
    end
  end


  describe 'DELETE #destroy' do
    before(:each) do
      @question = FactoryGirl.create(:question)
    end

    it "deletes the question" do
      expect{
      delete :destroy, id: @question}.to change(Question, :count).by(-1)
    end

    it 'redirects to questions index page' do
      delete :destroy, id: @question
      expect(response).to redirect_to questions_url
    end
  end


  describe "GET #edit" do
    let(:question) { FactoryGirl.create :question}
    it 'renders the #edit page' do
      get :edit, id: question.id
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    before(:each) do
      @question = FactoryGirl.create(:question)
    end


    it 'changes @question attributes' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question, title: "New Title", content: "New Body")
      @question.reload
      expect(@question.title).to eq("New Title")
      expect(@question.content).to eq("New Body")
    end
  end

end
