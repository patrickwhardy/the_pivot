class PhotoAssigner

  def self.call(tool)

    ###############################################################

    ### the fotofetcher gem is present for development purposes
    ### though it could be left in to provide default images in production,
    ### it's probably not cool to go jacking people's images/bandwidth

    @fetcher = Fotofetch::Fetch.new
    url = @fetcher.fetch_links(tool.name).values.first
    tool.image_path = url if tool.image_path.empty?

    ###############################################################

  end

end
