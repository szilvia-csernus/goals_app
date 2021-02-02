module ApplicationHelper
    include ERB::Util
        
    def auth_token
        html = "<input type='hidden' name='authenticity_token' value="
        html += "#{h(form_authenticity_token)} />"

        html.html_safe
    end
end
