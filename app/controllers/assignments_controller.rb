class AssignmentsController < ApplicationController

  def index
    @assignments = Assignment.all
    @assignment = Assignment.first
  end

  def new
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.save

    redirect_to action: "index"
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(article_params)
      redirect_to action: "index"
    else
      render "edit"
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    redirect_to action: "index"
  end

  def alert
    @assignment = Assignment.first
    @assignment.send_update params[:phone]

    redirect_to action: "index"
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :description, :subject, :due_date)
  end
end
