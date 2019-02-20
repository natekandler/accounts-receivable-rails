class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  after_action :save_line_items, except: [:index]

  def index
    @invoices = Invoice.all
  end

  def show
    @client = @invoice.client
    @line_items = invoice_presenter.group_line_items(@invoice) 
    @total = invoice_presenter.calculate_total(@line_items)
  end

  def new
    @invoice = Invoice.new
  end

  def edit
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to @invoice, notice: 'Invoice was successfully created.'
    else
      render :new
    end
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: 'Invoice was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'
  end



  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def save_line_items
      return if @invoice.blank?
      @invoice.line_items.each(&:save)
    end

    def invoice_params
      params.require(:invoice).permit(:client_id, :net_days, :note)
    end

    def invoice_presenter
      @invoice_presenter || InvoicePresenter.new(params[:convert])
    end
end
