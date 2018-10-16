require "test_helper"

class InvoicesControllerTest < ActionController::TestCase
  def test_index
    get :index

    assert_equal Invoice.all, assigns(:invoices)
  end

  def test_show_assigns_a_client
    invoice = invoices(:build)

    get :show, params: { id: invoice.id, }

    assert_equal clients(:acme), assigns(:client)
  end

  def test_show_assigns_line_items
    invoice = invoices(:build)

    get :show, params: { id: invoice.id, }

    line_items = assigns(:line_items)
    assert_equal line_items[:product].count, 1
    assert_equal line_items[:service].count, 2
  end

  def test_show_assigns_a_total
    invoice = invoices(:build)

    get :show, params: { id: invoice.id, }

    assert_equal 2_480_000, assigns(:total)
  end
end
