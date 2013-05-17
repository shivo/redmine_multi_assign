require 'redmine'

Redmine::Plugin.register :redmine_multi_assign do
  name 'Redmine Multi Assign plugin'
  author 'Juraj Sujan aka shivo, AXON PRO s.r.o.'
  description 'Plugin that allows to add and edit multiple project to user assignments (memberships) at once'
  version '0.1.0'
  url 'https://github.com/axonpro/redmine_multi_assign'
  author_url 'https://github.com/axonpro'
end

# Patches to the Redmine core.
require 'dispatcher'
require 'users_controller_patch'

Dispatcher.to_prepare :redmine_multi_assign do
  require_dependency 'users_controller'
  unless UsersController.included_modules.include? RedmineMultiAssign::Patches::UsersControllerPatch
    UsersController.send(:include, RedmineMultiAssign::Patches::UsersControllerPatch)
  end
end
