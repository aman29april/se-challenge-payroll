Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  root to: Rswag::Ui::Engine
  namespace :api do
    resources :file_imports, only: [:create]
    resources :payroll_reports, only: %i[index show]
  end
end
