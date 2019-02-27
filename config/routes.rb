Rails.application.routes.draw do
  devise_scope :user do
    authenticated :user do
      root 'apps#console', as: :authenticated_root
    end
    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  devise_scope :super_admin do
    authenticated :super_admin do
      root 'apps#console', as: :authenticated_sa_root
    end
    unauthenticated do
      root to: 'sessions#new', as: :unauthenticated_sa_root
    end
  end

  get 'apps/console' #main landing page
  get '/user_account', to: 'users#show'
  get '/users/:id/delete', to: 'super_admins#view_delete_user', as: :view_user_delete
  delete '/user/:id', to: 'super_admins#destroy'
  get 'new_user', to: 'super_admins#invite_user'
  post 'new_user', to: 'super_admins#invite', as: :invitation_invite

  get 'apps/super_admin_console', to: 'super_admins#super_admin_console'
  # get '/agent_account', to: 'agents#show'

  get '/new_app', to: 'apps#new'
  post '/new_app', to: 'apps#create'
  # get '/app_count', to: 'apps#app_count'

  # Route to create an relationship between a user and an App.
  post '/:app_id/invite_user_to_app', to: 'invitations#create', as: :invitation_create

  get '/app/:id', to: 'apps#show'
  get '/user/:id', to: 'super_admins#admin_user_show', as: :admin_user
  get '/app_key/:id', to: 'apps#app_key', as: :app_key
  get 'agent_invite', to: 'super_admins#invite_agent'

  devise_for :super_admins, controllers: {registrations: "super_admin/registrations", sessions: "super_admin/sessions"},
    :path_names => {:sign_in => "login"}


  devise_for :users, controllers: {registrations: 'user/registrations', sessions: 'sessions'}

  resources :apps do
    resources :important_messages, :except => [:new, :create, :index, :update] do
    end
    resources :messages, :except => [:new, :create, :index] do
    end

    get '/config_push_notifications', to: 'apps#config_push_notifications'
    get '/config_users', to: 'apps#config_users'

    get '/show_user/:user_id', to: 'apps#show_user', as: :show_user
    get '/remove_user/:user_id', to: 'apps#remove_user_association', as: :remove_user
    get '/update', to: 'apps#update'
    post '/update', to: 'apps#update'
    get '/total', to: 'stats#total'
    get '/delete', to: 'apps#view_delete'
    delete '/delete', to: 'apps#destroy'
    get '/invite_user_form', to: 'invitations#invite_form'
    get '/agent_invite', to: 'invitations#agent_invite_form'
    get '/show_remove_button/:user_id', to: 'invitations#show_destroy', as: :show_remove_button
  end

  get '/app/:app_id/messages', to: 'messages#index', as: :app_message_index
  get 'app/:app_id/new_message', to: 'messages#new', as: :new_message
  post 'app/:app_id/messages', to: 'messages#create', as: :create_message

  get '/app/:app_id/important_messages', to: 'important_messages#index', as: :app_important_message_index
  get 'app/:app_id/new_important_message', to: 'important_messages#new', as: :new_important_message

  post 'app/:app_id/important_messages', to: 'important_messages#create', as: :create_important_message
  get '/apps/:app_id/email_frequency', to: 'apps#email_frequency', as: :app_email_frequency
  post '/apps/:app_id/email_frequency', to: 'apps#email_frequency_update', as: :app_email_frequency_update

  get '/users/:id/user_status', to: 'super_admins#user_status', as: :user_update
  post '/users/:id/user_status', to: 'super_admins#update_user_status', as: :user_update_status

  namespace :api do
    namespace :v1 do
      get '/apps/:app_key/first_run', to: 'events#first_run'
      post '/apps/:app_key/register_device', to: 'devices#create'
      get '/apps/:app_key/app_session', to: 'events#app_session'
      get '/docs', to: 'api_docs#index'
    end
  end
end
