class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:edit, :update, :show]

  def index
    @suppliers = Supplier.all
 end

 def new
    @supplier = Supplier.new
 end

 def show; end

 def edit; end

 def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save()
       redirect_to @supplier, notice: "Fornecedor cadastrado com sucesso."
    else
       flash.now[:alert] = "Fornecedor não cadastrado."
       render 'new'
    end
 end

 def update
    @supplier.update(supplier_params)
    if @supplier.save()
       redirect_to supplier_path(@supplier), notice: 'Fornecedor atualizado com sucesso.'
    else
       flash.now[:notice] = "Não foi possível atualizar o fornecedor."
       render 'edit'
    end
 end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :city, :full_address, :registration_number, :state, :email)
  end
end