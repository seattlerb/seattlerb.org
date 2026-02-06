Rails.application.configure do
  MissionControl::Jobs.base_controller_class = "AdminController"
  MissionControl::Jobs.http_basic_auth_enabled = false
  MissionControl::Jobs.adapters = [ :solid_queue ]
end if defined? MissionControl::Jobs
