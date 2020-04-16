class GraphqlController < ApplicationController
  include Rails.application.routes.url_helpers
  include Knock::Authenticable
  include CanCan::ControllerAdditions # Permissions
  before_action :authenticate_admin
  

  def unauthorized_entity(args)
  end


  def index
    #render plain: GraphQL::Schema::Printer.new(V1PSchema).print_schema
    if request.format.json?
      render plain: JSON.pretty_generate(V1PSchema.execute(GraphQL::Introspection::INTROSPECTION_QUERY)["data"])
    else 
      render plain: V1PSchema.to_definition
    end
  end

  def execute
    context = {
      # Query context goes here, for example:
      current_user: current_admin,
    }

    # Apollo sends the params in a _json variable when batching is enabled
    # see the Apollo Documentation about query batching: http://dev.apollodata.com/core/network.html#query-batching
    if params[:_json] && Rails.env.development?
      puts request.headers['Authorization'] if request.headers.key?("Authorization")
      params[:_json].map do |q|
        puts q[:variables]
        puts q[:query] if q.key?(:query)
      end
    end
    result = if params[:_json]
                queries = params[:_json].map do |param|
                  {
                    query: param[:query],
                    operation_name: param[:operationName],
                    variables: ensure_hash(param[:variables]),
                    context: context
                  }
                end
                V1PSchema.multiplex(queries)
              else
                V1PSchema.execute(
                  params[:query],
                  operation_name: params[:operationName],
                  variables: ensure_hash(params[:variables]),
                  context: context
                )
            end

    render json: result.to_json
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end
  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end
end