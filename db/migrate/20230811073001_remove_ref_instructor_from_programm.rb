class RemoveRefInstructorFromProgramm < ActiveRecord::Migration[7.0]
  def change
    remove_reference :programms, :instructor
    add_reference :programms, :user
  end
end

