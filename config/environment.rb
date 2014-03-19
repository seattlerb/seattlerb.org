# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SeattlerbOrg::Application.initialize!

Date::DATE_FORMATS[:friendly_talk_date] = "%B %e, %Y"
