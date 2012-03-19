# To change this template, choose Tools | Templates
# and open the template in the editor.

module UnassignSubprojectsUsersControllerPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      before_filter :find_user, :only => [:show, :edit, :update, :destroy, :edit_membership, :destroy_membership, :unassign_subprojects]
    end
  end

  module InstanceMethods
    def unassign_subprojects
      Member.delete_all("user_id = #{@user.id}")
      respond_to do |format|
        format.html { redirect_to :controller => 'users', :action => 'edit', :id => @user, :tab => 'memberships' }
        format.js {
          render(:update) {|page|
            page.replace_html "tab-content-memberships", :partial => 'users/memberships'
            page.visual_effect(:highlight, "member-#{@membership.id}")
          }
        }
      end
    end
  end
end
