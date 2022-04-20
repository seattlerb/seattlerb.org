Rails.application.config.action_view.form_with_generates_remote_forms = false
# Rails.application.config.assets.unknown_asset_fallback = false
Rails.application.config.active_record.belongs_to_required_by_default = false
# dunno why: https://github.com/rails/rails/issues/23589
ActiveRecord::Base.belongs_to_required_by_default = false
