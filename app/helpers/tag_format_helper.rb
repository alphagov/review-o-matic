module TagFormatHelper
  def format_tag(tag)
    tag.gsub('-',' ').humanize
  end
end