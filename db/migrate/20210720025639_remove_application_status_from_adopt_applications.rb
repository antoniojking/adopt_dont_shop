class RemoveApplicationStatusFromAdoptApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :adopt_applications, :application_status, :string
  end
end
