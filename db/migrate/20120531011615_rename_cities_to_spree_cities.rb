class RenameCitiesToSpreeCities < ActiveRecord::Migration
  def change
    rename_table :cities, :spree_cities
  end
end
