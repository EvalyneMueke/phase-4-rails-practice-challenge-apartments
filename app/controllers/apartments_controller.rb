class ApartmentsController < ApplicationController
    def index
        render json: Apartment.all, status: :ok
    end

    def show 
        apartment = find_apartment
        if apartment
            render json: apartment
        else 
            render json: {error: "Apartment not found"},status: :not_found
        end


    end
    
    def create 
        apartment = Apartment.create!(apartment_params)
        
            render json: apartment , status: :created
        rescue ActiveRecord::RecordInvalid => e
            render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
            

    def update 
        apartment = find_apartment
        if apartment.update(apartment_params)
            render json: apartment
        else 
            render json: {error: "Apartment not updated"}, status: :uproccessable_entity
        end
    end

    def destroy
        apartment = find_apartment
        if apartment
            apartment.destroy
            head :no_content
        else 
            render json: {error: "Apartment not found"}, status: :not_found
        end

    end


    private

    def find_apartment
        apartment = Apartment.find(params[:id])
    end

    def apartment_params
        params.permit(:number)
    end
end
