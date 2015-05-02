class AddCohortTables < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.datetime :start_on
      t.datetime :end_on
    end

    add_column :groups, :cohort_id, :integer
    add_index :groups, :cohort_id

    create_table :group_measurements do |t|
      t.integer :group_id
      t.integer :measured_on
      t.integer :members_count
      t.integer :invitations_count
      t.integer :discussions_count
      t.integer :proposals_count
      t.integer :comments_count
      t.integer :likes_count
      t.integer :events_count
    end

    add_index :group_measurements, :group_id
    add_index :group_measurements, :measured_on
  end
end
