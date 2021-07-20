class AddStatusToAdoptApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :adopt_applications, :status, :string, default: 'In Progress'
  end
end
