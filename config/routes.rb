Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  get "/graphql", to: "graphql#index"

  get '/asset/avatar/:id', to: "assets#avatar"
  get '/asset/logo/:id', to: "assets#logo"
end