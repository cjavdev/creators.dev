module ApplicationHelper

  def gravatar_url
    gravatar_id = Digest::MD5::hexdigest(current_user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  def menu_items
    [{
      name: 'Dashboard',
      path: dashboard_path,
    }, {
      name: 'Accounts',
      path: accounts_path
    }, {
      name: 'Products',
      path: products_path,
    }, {
      name: 'Store',
      path: store_path,
    }, {
      name: 'Customers',
      path: customers_path,
    }, {
      name: 'Cardholders',
      path: cardholders_path,
    }].map do |item|
      {
        name: item[:name],
        path: item[:path],
        active: current_page?(item[:path])
      }
    end
  end
end
