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
require 'member_patch'
require 'users_controller_patch'

Dispatcher.to_prepare :redmine_multi_assign do
  require_dependency 'member'
  unless Member.included_modules.include? RedmineMultiAssign::Patches::MemberPatch
    Member.send(:include, RedmineMultiAssign::Patches::MemberPatch)
  end

  require_dependency 'users_controller'
  unless UsersController.included_modules.include? RedmineMultiAssign::Patches::UsersControllerPatch
    UsersController.send(:include, RedmineMultiAssign::Patches::UsersControllerPatch)
  end
end
