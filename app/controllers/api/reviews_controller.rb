class Api::ReviewsController < Api::ApiController
    skip_before_action :login_required, only: [:index, :create]
    before_action :admin_required, except: [:update, :destroy]

    def index
        reviews = Dealership.find(params[:dealership_id])&.reviews

        if reviews
            render_success(:ok, reviews)
          else
            render_error(:not_found, reviews.errors)
        end
    end

    def create
        review = current_user.reviews.new(review_params)
        review.dealership_id = params[:dealership_id]
    
        if review.save
          render_success(:created, review, meta: { message: I18n.t("Review record created...!") })
        else
          render_error(:unprocessable_entity, review.errors)
        end
    end

    def update
        review = current_user.reviews.find(params[:dealership_id])
    
        if review.update(review_update_params)
          render_success(:ok, review, meta: { message: I18n.t("Review record updated...!") })
        else
          render_error(:unprocessable_entity, review.errors)
        end
    end

    def destroy
        review = current_user.reviews.find(params[:dealership_id])
    
        if review.destroy
          render_success(:ok, review, meta: { message: I18n.t("Review record deleted...!") })
        else
          render_error(:unprocessable_entity, review.errors)
        end
    end
  
    private
  
    def review_params
        params.require(:review).permit(:rating, :comment, :title)
    end

    def review_update_params
        params.require(:review).permit(:visible)
    end
end
