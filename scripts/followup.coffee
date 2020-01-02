# Description:
#   Show open issues from a Github repository
# Commands:
#   hubot followup -- Shows all issues to follow up.
_  = require("underscore")
ASK_REGEX = /followup\s*/i

module.exports = (robot) ->
  github = require("githubot")(robot)
  issues = process.env.HUBOT_FOLLOWUP_LABELS;
  robot.respond ASK_REGEX, (msg) ->
    # Query Parameter
    query_params = state: "open", sort: "created"
    query_params.per_page=100
    query_params.labels = 'good first issue'

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_REPOFRONTEND}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          labels = ("`##{label.name}`" for label in issue.labels).join(" ")
          msg.send "Hey @here, here's a new issue for you: [`#{issue.number}`] *#{issue.title} #{labels}* #{issue.html_url}"
      else
        msg.send "Congratulations! Nothing to followup on Frontend repository!"
    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_REPOCOMPONENTS}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          labels = ("`##{label.name}`" for label in issue.labels).join(" ")
          msg.send "Hey @here, here's a new issue for you: [`#{issue.number}`] *#{issue.title} #{labels}* #{issue.html_url}"
      else
        msg.send "Congratulations! Nothing to followup on Components repository!"
    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_REPOSERVER}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          labels = ("`##{label.name}`" for label in issue.labels).join(" ")
          msg.send "Hey @here, here's a new issue for you: [`#{issue.number}`] *#{issue.title} #{labels}* #{issue.html_url}"
      else
        msg.send "Congratulations! Nothing to followup on Server repository!"
