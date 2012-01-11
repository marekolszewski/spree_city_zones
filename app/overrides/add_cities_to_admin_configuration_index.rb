Deface::Override.new(
  :name => "add_cities_to_admin_configuration_index",
  :virtual_path => "admin/configuration/index",
  :insert_bottom => "[data-hook='admin_configurations_menu']",
  :partial => "shared/cities_admin_configurations_menu")