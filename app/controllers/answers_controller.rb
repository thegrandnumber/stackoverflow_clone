class AnswersController < ApplicationController

    def create
    question = Question.find(params[:question_id])
    answer = question.answers.new(params_answers)

    respond_to do |format|
      if answer.save
        format.html {redirect_to question_path(question)}
        format.json {render json: answer}
      else
        format.html {render 'show'}
        format.json {render json: @errors}
      end
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
  end

  def update
    question = Question.find(params[:question_id])
    answer = Answer.find(params[:id])
    answer.update(params_answers)
    redirect_to question_path(question)
  end 

  def destroy
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.destroy
    respond_to do |format|
      format.html {redirect_to @question}
      format.json { render json: @answer}
    end
  end 

  

  private

  def params_answers
    params.require(:answer).permit(:title, :content)
  end
end
