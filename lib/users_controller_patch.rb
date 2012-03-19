
module RedmineMultiAssign
  module Patches
    module UsersControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          before_filter :find_user, :only => [:show, :edit, :update, :destroy, :edit_membership, :destroy_membership, :unassign_projects]
        end
      end

      module InstanceMethods
        def unassign_projects
          Member.delete_all("user_id = #{@user.id}")
          respond_to do |format|
            format.html { redirect_to :controller => 'users', :action => 'edit', :id => @user, :tab => 'memberships' }
            format.js { render(:update) {|page| page.replace_html "tab-content-memberships", :partial => 'users/memberships'} }
          end
        end
      end
    end
  end
end
