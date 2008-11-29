module EpisodesHelper
  def fields_for_download(download, &block)
    new_or_existing = download.new_record? ? 'new' : 'existing'
    prefix = "episode[#{new_or_existing}_download_attributes][]"
    fields_for(prefix, download, &block)
  end
  
  def link_to_episode(episode)
    text =  "##{episode.position} "
    text << h(episode.name)
    link_to_unless_current text, episode
  end
end
