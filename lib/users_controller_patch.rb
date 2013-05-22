
module RedmineMultiAssign
  module Patches
    module UsersControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          before_filter :find_user, :only => [:show, :edit, :update, :destroy, :edit_membership, :edit_memberships, :destroy_membership, :rma_add_memberships, :rma_edit_memberships]
        end
      end

      module InstanceMethods
        def rma_add_memberships
          @success = true
          if params[:memberships]
            params[:memberships][:project_ids] ||= []
            params[:memberships][:project_ids].each do |project_id|
              params[:membership][:project_id] = project_id
              @membership = Member.edit_membership(params[:membership_id], params[:membership], @user)
              unless @membership.save
                #rma_error(format, @membership.errors)
                @errors = @membership.errors
                @success = false
              end
            end
          else
            @errors = "no membership selected"
            @success = false
          end
          respond_to do |format|
            format.html { redirect_to edit_user_path(@user, :tab => 'memberships') }
            format.js
          end
        end

        def rma_edit_memberships
          @success = true
          params[:memberships] ||= []
          params[:memberships].values.each do |membership_params|
            if membership_params[:checked]
              membership = Member.find(membership_params[:id])
              if membership
                if params[:rma_edit_action] == 'delete'
                  unless membership.delete
                    @success = false
                    @errors = "Cannot delete membership"
                  end
                elsif params[:rma_edit_action] == 'edit_roles'
                  unless membership.update_attributes(params[:membership])
                    @success = false
                    @errors = "Cannot update membership"
                  end
                end
              end
            end
          end
          respond_to do |format|
            format.html { redirect_to edit_user_path(@user, :tab => 'memberships') }
            format.js
          end
        end
      end
    end
  end
end
