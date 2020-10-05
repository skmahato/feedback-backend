require "auth"

class Api::ApiController < ActionController::API
  before_action :login_required

  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  protected

  def login_required
    render_error(:unauthorized, ["Login required"]) unless current_user
  end

  def admin_required
    render_error(:unauthorized, ["Not Authorized"]) unless current_user&.admin?
  end

  def current_user
    @current_user ||= if auth_present?
                        User.find_by(id: auth.first["user"]) if auth.first["exp"] > Time.zone.now.to_i
                      end
  end

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first.present?
  end

  def render_json_api(resource, options = {})
    options[:adapter]               ||= :json_api
    options[:namespace]             ||= Api
    options[:key_transform]         ||= :camel_lower
    options[:serialization_context] ||= ActiveModelSerializers::SerializationContext.new(request)
    options[:serializer]              = Api::NullSerializer unless resource
    ActiveModelSerializers::SerializableResource.new(resource, options)
  end

  def render_success(status, resource, options = {})
    render json: render_json_api(resource, options).as_json, status: status
  end

  def render_error(status, errors = [], meta = {})
    if errors.is_a?(ActiveModel::Errors)
      render json: { errors: Hash[errors.keys.map { |f| [f, errors.full_messages_for(f)] }], meta: meta }, status: status
    else
      render json: { errors: errors, meta: meta }, status: status
    end
  end

  def not_found!
    render_error(:not_found, ["Record not found"])
  end
end
