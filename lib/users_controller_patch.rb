
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
          respond_to do |format|
            success = true
            params[:memberships][:project_ids] ||= []
            params[:memberships][:project_ids].each do |project_id|
              params[:membership][:project_id] = project_id
              @membership = Member.edit_membership(params[:membership_id], params[:membership], @user)
              @membership.save
              unless @membership.valid?
                rma_error(format, @membership.errors)
                success = false
              end
            end
            if success
              rma_success(format)
            end
          end
        end

        def rma_edit_memberships
          respond_to do |format|
            params[:memberships] ||= []
            params[:memberships].values.each do |membership_params|
              if membership_params[:checked]
                membership = Member.find(membership_params[:id])
                if membership
                  if params[:rma_edit_action] == 'delete'
                    membership.delete
                  elsif params[:rma_edit_action] == 'edit_roles'
                    membership.attributes = params[:membership]
                    membership.save
                  end
                end
              end
            end
            rma_success(format)
#            else
#              format.js {
#                  render(:update) {|page|
#                    page.alert(l(:notice_failed_to_save_members, :errors => @user.errors.full_messages.join(', ')))
#                  }
#                }
#            end
          end
        end

        private

        def rma_success(format)
            format.html { redirect_to :controller => 'users', :action => 'edit', :id => @user, :tab => 'memberships' }
            format.js {
                render(:update) {|page|
                  page.replace_html "tab-content-memberships", :partial => 'users/memberships'
                  page << "rma_observe_edit_buttons();"
                }
              }
        end

        def rma_error(format, errors)
          format.js {
            render(:update) {|page|
              page.alert(l(:notice_failed_to_save_members, :errors => errors.full_messages.join(', ')))
            }
          }
        end
      end
    end
  end
end
