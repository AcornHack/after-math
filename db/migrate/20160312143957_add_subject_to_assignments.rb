class AddSubjectToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :subject, :string
  end
end
