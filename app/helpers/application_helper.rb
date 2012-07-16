module ApplicationHelper

  def edit_migratorator_mapping_url(mapping_id)
    Plek.current.find("migratorator") + "/mappings/#{mapping_id}/edit"
  end

  def explorer_path
    Plek.current.find("explore") +  explore_path
  end

end
