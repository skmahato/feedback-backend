class Api::DealershipsController < Api::ApiController
    skip_before_action :login_required, only: [:index, :show]
    before_action :admin_required, except: [:index, :show, :create]

    def index
        dealerships = Dealership.all

        if dealerships
            render_success(:ok, dealerships, include: [:reviews, :user])
          else
            render_error(:not_found, dealerships.errors)
        end
    end

    def show
        dealership = Dealership.find(params[:id])

        if dealership
            render_success(:ok, dealership, include: [:reviews, :user])
          else
            render_error(:not_found, dealership.errors)
        end
    end

    def create
        dealership = current_user.build_dealership(dealership_params)
    
        if dealership.save && current_user.update_attribute(:admin, true)
          render_success(:created, dealership, include: [:reviews, :user], meta: { message: I18n.t("Dealership record created...!") })
        else
          render_error(:unprocessable_entity, dealership.errors)
        end
    end

    def update
        dealership = current_user.dealership
    
        if dealership.update(dealership_params)
          render_success(:ok, dealership, include: [:reviews, :user], meta: { message: I18n.t("Dealership record updated...!") })
        else
          render_error(:unprocessable_entity, dealership.errors)
        end
    end

    def destroy
        dealership = current_user.dealership

        if dealership.destroy && current_user.update_attribute(:admin, false)
            render_success(:ok, dealership, include: [:reviews, :user], meta: { message: I18n.t("Dealership record deleted...!") })
        else
          render_error(:unprocessable_entity, dealership.errors)
        end
    end
  
    private
  
    def dealership_params
        params.require(:dealership).permit(:email, :name, :location, :description, :phone, :website)
    end
end
