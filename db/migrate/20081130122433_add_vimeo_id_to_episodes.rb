class AddVimeoIdToEpisodes < ActiveRecord::Migration
  def self.up
    add_column(:episodes, :vimeo_id, :integer)
  end

  def self.down
    remove_column(:episodes, :vimeo_id)
  end
end
