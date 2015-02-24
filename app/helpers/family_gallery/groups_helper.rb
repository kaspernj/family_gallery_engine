module FamilyGallery::GroupsHelper
  def link_to_group(group)
    group_name = group.name
    group_name = "[#{FamilyGallery::Group.model_name.human} #{group.id}]" unless group_name.present?

    link_to group_name, group
  end
end
