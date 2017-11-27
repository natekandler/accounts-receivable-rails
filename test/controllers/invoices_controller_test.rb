require "test_helper"

class InvoicesControllerTest < ActionController::TestCase
  def test_index
    get :index

    assert_equal Invoice.all, assigns(:invoices)
  end

  def test_show

  end
end
