Deface::Override.new(
  :name => "add_cities_to_admin_configuration_index",
  :virtual_path => "spree/admin/configurations/index",
  :insert_bottom => "[data-hook='admin_configurations_menu']",
  :partial => "spree/shared/cities_admin_configurations_menu")
