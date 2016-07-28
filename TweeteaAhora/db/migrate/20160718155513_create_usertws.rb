class CreateUsertws < ActiveRecord::Migration
  def change
    create_table :usertws do |u|
      u.string :user

      u.timestamp
    end
  end
end
