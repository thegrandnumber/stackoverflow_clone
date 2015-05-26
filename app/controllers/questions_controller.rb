class QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  def create
    @question = Question.new(params_question)
    respond_to do |format|
      if @question.save
        format.html {redirect_to question_path(@question)}
        format.json {render json: @question}
      else

        format.html {render 'index'}
        format.json {render json: @errors}
      end
    end
  end


  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(params_question)
    redirect_to question_path(@question)
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to questions_path
  end

  

  private

  def params_question
    params.require(:question).permit(:title, :content)
  end
end
