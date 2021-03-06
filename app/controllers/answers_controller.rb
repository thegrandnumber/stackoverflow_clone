class AnswersController < ApplicationController

    def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(params_answers)
    @errors = @answer.errors.full_messages.to_sentence


    respond_to do |format|
      if @answer.save
        format.html {redirect_to question_path(@question)}
        format.json {render json: @answer}
      else
        format.html {render 'show'}
        format.json {render json: @errors, status: :unprocessable_entity }
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

  def upvote
    answer = Answer.find(params[:id])
    question = answer.question
    answer.vote_count += 1
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

  def downvote
    answer = Answer.find(params[:id])
    question = answer.question
    answer.vote_count -= 1
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
