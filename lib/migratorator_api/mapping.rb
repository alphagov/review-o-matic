class MigratoratorApi
  class Mapping
    def self.find_by_old_url(old_url, options = {})
      page = options[:page] || 1
      format_mapping_reponse MigratoratorApi.client.get("/mappings.json?old_url=#{old_url}&page=#{page}")
    end

    def self.find_by_new_url(new_url, options = {})
      page = options[:page] || 1
      format_mapping_reponse MigratoratorApi.client.get("/mappings.json?new_url=#{new_url}&page=#{page}")
    end

    def self.all_by_tag(tags, options = {})
      page = options[:page] || 1
      format_mapping_reponse MigratoratorApi.client.get("/mappings.json?tags=#{tags}&page=#{page}")
    end

    def self.format_mapping_reponse(response)
      mappings = JSON.parse(response.body)["mappings"] || []
    end
  end
end