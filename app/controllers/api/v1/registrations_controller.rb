class RegistrationsController < Devise::RegistrationController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save!
      render json: resource, status: :created
    else
      render plain: 'not created', status: :bad_request, message: 'not created'
    end
  end
end