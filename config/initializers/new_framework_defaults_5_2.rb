Rails.application.config.active_record.cache_versioning = true
Rails.application.config.action_dispatch.use_authenticated_cookie_encryption = true
Rails.application.config.active_support.use_authenticated_message_encryption = true
Rails.application.config.action_controller.default_protect_from_forgery = true
Rails.application.config.active_support.hash_digest_class = ::Digest::SHA1
Rails.application.config.action_view.form_with_generates_ids = true
