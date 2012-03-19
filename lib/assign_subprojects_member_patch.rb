# To change this template, choose Tools | Templates
# and open the template in the editor.

module AssignSubprojectsMemberPatch
  def self.included(base) # :nodoc:
#    base.send(:include, InstanceMethods)
#
#    base.class_eval do
#      alias_method_chain :edit_membership, :assign_subprojects
#    end

    base.extend ClassMethods

    base.class_eval do
      unloadable
      class << self
        alias_method_chain :edit_membership, :assign_subprojects
      end
    end

  end

  module ClassMethods
    def edit_membership_with_assign_subprojects(id, new_attributes, principal=nil)
      assign_subprojects = new_attributes['assign_subprojects']
      new_attributes.delete('assign_subprojects')
      membership = edit_membership_without_assign_subprojects(id, new_attributes, principal)
      if (assign_subprojects)
        parent_project = Project.find(new_attributes['project_id'])
        if parent_project
          parent_project.descendants.each do |subproject|
            submembership = Member.new(:principal => principal)
            submembership.attributes = new_attributes
            submembership.project = subproject
            submembership.save
          end
        end
      end
      membership
    end
  end
end
