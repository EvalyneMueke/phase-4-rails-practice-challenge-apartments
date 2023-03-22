class TenantsController < ApplicationController

    def create
        tenant = Tenant.create(tenant_params)
        if tenant.valid?
            render json: tenant, status: :created
        else
            render json: { errors: ["Invalid parameters"] }, status: :unprocessable_entity
        end
    end

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            render json: tenant
        else
            render json: { errors: ["Tenant not found"] }, status: :not_found
        end
    end

    def update
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.update(tenant_params)
            render json: tenant
        else
            render json: { errors: ["Tenant not found"] }
        end
    end

    def destroy
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.destroy
            head :no_content
        else
            render json: { errors: ["Tenant not found"] }, status: :not_found
        end
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

end
