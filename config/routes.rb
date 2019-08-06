Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'areas' => 'geo#get_areas'
  post 'areas' => 'geo#inside'
end
