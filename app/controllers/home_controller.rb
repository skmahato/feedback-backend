class HomeController < ApplicationController
    def index
        if params[:token]
            id = params[:token]&.split('-')[0]
            if id
                reviews = Dealership.find_by(id: id)&.reviews&.only_visible || []
                render json: reviews
            else
                render json: :ok
            end
        else
            render json: :ok
        end
        
    end
end
