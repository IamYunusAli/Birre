class CreateJoinTableDealCategory < ActiveRecord::Migration[7.0]
  def change
    create_join_table :deals, :categories do |t|
    end
  end
end
