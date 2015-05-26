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

  

  private

  def params_answers
    params.require(:answer).permit(:title, :content)
  end
end
