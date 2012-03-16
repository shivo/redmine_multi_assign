require 'redmine'

Redmine::Plugin.register :redmine_multi_assign do
  name 'Redmine Multi Assign plugin'
  author 'Juraj Šujan'
  description 'Plugin allows to assign project and all its subprojects to user at once'
  version '0.0.1'
  url 'https://github.com/shivo/redmine_multi_assign'
  author_url 'https://github.com/shivo'
end

# Patches to the Redmine core.
require 'dispatcher'
require 'assign_subprojects_member_patch'

Dispatcher.to_prepare do
  unless Member.included_modules.include? AssignSubprojectsMemberPatch
    Member.send(:include, AssignSubprojectsMemberPatch)
  end
end
