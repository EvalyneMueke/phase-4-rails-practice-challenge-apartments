class LeasesController < ApplicationController
    def index
        render json: Lease.all, status: :ok
    end

    def show
        lease =  find_lease
        if lease
        render json: lease,status: :ok
        else 
            render json: {error:"Lease not found"}, status: :not_found
        end


    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease ,status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update
        lease = find_lease
        if lease = Lease.update(lease_params)
            render json: lease
        else
            render json: {error: "Not updated"},status: :unprocessable_entity
        end
    end

    def destroy 
        lease = find_lease
        if lease 
            lease.destroy
            head :no_content
        else 
            render json:{error: "Lease not found"}, status: :not_found
        end
    end


    private
    def find_lease
        lease = Lease.find(params[:id])

    end

    def lease_params
        params.permit(:rent,:tenant_id, :apartment_id)
    end


    
end
