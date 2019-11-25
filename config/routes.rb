Rails.application.routes.draw do

  resources :ideas do
    resources :reviews, only: [:create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]
  #   # The `shallow: true` named argument will separate
  #   # routes that require the parent from those that don't.
  #   # Routes that require the parent will not change (i.e. index, new, create).
  #   # Routes that don't require the parent (i.e. show, edit, update,
  #   # destroy) will have the parent prefix (i.e. /question/:question_id)
  #   # removed

  #   # Example
  #   # /questions/1/likes/5 becomes: /likes/5

  #   # /questions/liked
  #   # Use the `on` named argument to specify how a nested route
  #   # behaves relative to its parent.

  #   # `on: :collection` means that it acts on the entire resource
  #   # All questions in this case.

  #   # `on:  :member` means that it acts on a single resource. A
  #   # single question in this case.
    get :liked, on: :collection
  end


  resources :users, only:[:new, :create]

  # resource :session, only: [:new, :create, :destroy]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

 get('/', {to: 'ideas#index', as: 'root'})




  
  # resources :questions do
  #   resources :answers, only: [:create, :destroy]
  #   resources :likes, shallow: true, only: [:create, :destroy]
  #   # The `shallow: true` named argument will separate
  #   # routes that require the parent from those that don't.
  #   # Routes that require the parent will not change (i.e. index, new, create).
  #   # Routes that don't require the parent (i.e. show, edit, update,
  #   # destroy) will have the parent prefix (i.e. /question/:question_id)
  #   # removed

  #   # Example
  #   # /questions/1/likes/5 becomes: /likes/5

  #   # /questions/liked
  #   # Use the `on` named argument to specify how a nested route
  #   # behaves relative to its parent.

  #   # `on: :collection` means that it acts on the entire resource
  #   # All questions in this case.

  #   # `on:  :member` means that it acts on a single resource. A
  #   # single question in this case.
  #   get :liked, on: :collection
  # end

  # # resources :answers, only: [] do
  # #   resources :likes, shallow: true, only: [:create, :destroy]
  # # end



  # resources :job_posts, only: [:new, :create, :show, :destroy, :index]

  # # This defines a route rule that says when we receive
  # # a GET request with the URL '/', handle it with the
  # # WelcomeController with the index action inside that
  # # controller.
 

  # get '/contacts/new', {to: 'contacts#new' }
  # post '/contacts', {to: 'contacts#create'}
  # # get '/questions/:id', {to: 'questions#show', as: :question }

  # match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
