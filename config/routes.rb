RedmineApp::Application.routes.draw do
  match 'users/:id/rma_add_memberships', :to => 'users#rma_add_memberships', :via => :post, :as => "rma_add_memberships"
  match 'users/:id/rma_edit_memberships', :to => 'users#rma_edit_memberships', :via => :post, :as => "rma_edit_memberships"
end
