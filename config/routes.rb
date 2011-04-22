RubyfiedBlog::Application.routes.draw do

  match '/login' => 'sessions#new'
  match '/logout' => 'sessions#destroy'
  match '/register' => 'users#new'
  match '/forgot' => 'sessions#forgot'
  match '/reset' => 'sessions#reset'
  match '/activate/:activation_code' =>'users#activate'
  root :to=>'posts#index'

  resources 'users'
  resources 'links' do
    member do
      get 'move_up'
      get 'move_down'
    end
  end

  resources 'posts',:shallow=>true do
    resources 'comments' do
      member do
        get 'publish'
      end
    end
  end

  match '*a', :to => 'errors#routing' #TODO: create errors handling controller
end

