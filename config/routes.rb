Rails.application.routes.draw do


  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    resources :file_imports, only: [:create]
    resources :payroll_reports, only: [:index]
  end

end
