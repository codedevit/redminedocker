Rails.application.routes.draw do
  # Api V1
  match 'api/v1/issues_all/', :to => 'api_v1#issues_all', :as => 'api_v1_issues_all', :via => [:get, :post]
  match 'api/v1/issues_all_visible/', :to => 'api_v1#issues_all_visible', :as => 'api_v1_issues_all_visible', :via => [:get, :post]
  # Api V1
end
  