Rails.application.routes.draw do
  root 'metrics#index'

  get 'metric_values/index'
  get 'metric_values/edit'
  post 'metric_values/update'
  get 'metrics/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
