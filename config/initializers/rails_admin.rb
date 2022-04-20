# -*- coding: utf-8 -*-

RailsAdmin.config do |config|
  config.asset_source = :sprockets
  config.current_user_method { current_admin }

  config.main_app_name = ['Seattle.rb', 'Admin']

  config.label_methods << :date
end
