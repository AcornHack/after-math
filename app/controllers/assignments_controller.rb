class AssignmentsController < ApplicationController

  def index
    @assignments = Assignment.all
  end

  def new
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.save

    redirect_to action: "index"
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :description, :subject, :due_date)
  end
end
