title = "Railscasts.fr"
author = "Mathieu Fosse"
description = "Chaque semaine un nouveau screencast gratuit sur les Trucs et astuces avec Ruby on Rails."
keywords = "rails, ruby on rails, gratuit, screencasts, podcasts, astuces, tutoriels, training, programming, railscast"

if params[:ipod]
  title += " (iPod et Apple TV)"
  description += " Cette version est pour iPod ou Apple TV, une version avec une résolution plus importante et également disponible."
  keywords += ', ipod'
  image = "http://railscasts.fr/images/ipod_railscasts_cover.jpg"
  format = 'm4v'
else
  description += " C'est la version ayant la plus grande résolution, un format pour iPod est également disponible."
  image = "http://railscasts.fr/images/railscasts_cover.jpg"
  format = 'mov'
end


xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  :version => "2.0" do
  xml.channel do 
    xml.title title
    xml.link 'http://railscasts.fr'
    xml.description description
    xml.language 'fr'
    xml.pubDate @episodes.first.published_at.to_s(:rfc822)
    xml.lastBuildDate @episodes.first.published_at.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, 'clean'
    xml.itunes :image, :href => image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'mathieu.fosse@yeastymobs.com'
    end
    xml.itunes :block, 'no'
    xml.itunes :category, :text => 'Technology' do
      xml.itunes :category, :text => 'Software How-To'
    end
    xml.itunes :category, :text => 'Education' do
      xml.itunes :category, :text => 'Training'
    end
    
    @episodes.each do  |episode|
      download = episode.downloads.find_by_format(format)
      if download
        xml.item do
          xml.title "Episode #{episode.position}: #{episode.name}"
          xml.description episode.description
          xml.pubDate episode.published_at.to_s(:rfc822)
          xml.enclosure :url => download.url, :length => download.bytes, :type => 'video/quicktime'
          xml.link episode_url(episode)
          xml.guid({:isPermaLink => "false"}, episode.permalink)
          xml.itunes :author, author
          xml.itunes :subtitle, truncate(episode.description, 150)
          xml.itunes :summary, episode.description
          xml.itunes :explicit, 'no'
          xml.itunes :duration, download.duration
        end
      end
    end
  end
end
