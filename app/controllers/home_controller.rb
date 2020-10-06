class HomeController < ApplicationController
    def index
        if params[:token]
            id = params[:token]&.split('-')[0]
            reviews = Dealership.find_by(id: id)&.reviews&.only_visible
            if reviews
                render json: reviews, include: { user: { only: :name }}
            else
                render json: :ok
            end
        else
            render json: :ok
        end
    end

    def create
        if params[:token]
            id = params[:token]&.split('-')[0]

            if params[:user]
                user = User.new(user_params)
                user.password = SecureRandom.urlsafe_base64

                if user.save
                    review = user.reviews.build(review_params)
                    review.dealership_id = id

                    if review.save
                        render json: review, include: { user: { only: :name }}
                    else
                        render json: :unprocessable_entity, status: 404
                    end
                else
                    render json: :unprocessable_entity, status: 404
                end
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email)
    end

    def review_params
        params.require(:review).permit(:title, :comment, :rating)
    end
end
