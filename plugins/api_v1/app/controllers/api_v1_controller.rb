require 'net/http'
require 'uri'
require 'json'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
# DTI thales.dias: Criado controlador para comunicar com SEI
# https://docs.ruby-lang.org/en/3.0/Net/HTTP.html
class ApiV1Controller < ApplicationController
    # Verifica se existe o processo sei. Endpoint: /sei/get_process?sei=35014.000675/2023-89
    def issues_all
        if User.current.logged?
            if request.get? 
                # issues = Issue.all.select('id,tracker_id,project_id,due_date,category_id,priority_id,author_id,assigned_to_id').group_by(&:assigned_to_id)
                issue_array = Hash.new
                issues = Issue.all
                issues.each do |issue|
                    project_id = issue.project_id if issue.project_id?
                    project = issue.project.name if issue.project_id?
                    tracker_id = issue.tracker.id if issue.tracker_id?
                    tracker = issue.tracker.name if issue.tracker_id?
                    status_id = issue.status.id if issue.status_id?
                    status = issue.status.name if issue.status_id?
                    priority_id = issue.priority.id  if issue.priority_id?
                    priority = issue.priority.name  if issue.priority_id?
                    author_id = issue.author.id  if issue.author_id?
                    author = issue.author.name  if issue.author_id?
                    category_id = issue.category.id if issue.category_id?
                    category = issue.category.name if issue.category_id?
                    assigned_to_id = issue.assigned_to.id  if issue.assigned_to_id?
                    assigned_to = issue.assigned_to.name  if issue.assigned_to_id?
                    due_date = issue.due_date
                    closed_on = issue.closed_on
                    issue_array[issue.id] = {"id": issue.id, "project": {"id": project_id, "name": project}, "tracker": {"id": tracker_id, "name": tracker}, "status": {"id": status_id, "name": status}, "priority": {"id": priority_id, "name": priority}, "author": {"id": author_id, "name": author}, "assigned_to": {"id": assigned_to_id, "name": assigned_to}, "category": {"id": category_id, "name": category}, "due_date": due_date, "closed_on": closed_on}
                end
                issues_json = JSON.parse(issue_array.to_json)
                render json: {"issues": issues_json}
            end
        else
            logger.info("usuário não logado tentou acessar API")
            render json: {"error": "Usuário não logado"}, status: :unauthorized
        end
    end

    def issues_all_graph
        if User.current.logged?
            if request.get? 
                # issues = Issue.all.select('id,tracker_id,project_id,due_date,category_id,priority_id,author_id,assigned_to_id').group_by(&:assigned_to_id)
                issue_array = Hash.new
                issues = Issue.all
                issues.each do |issue|
                    # project_id = issue.project_id if issue.project_id?
                    # project = issue.project.name if issue.project_id?
                    tracker_id = issue.tracker.id if issue.tracker_id?
                    tracker = issue.tracker.name if issue.tracker_id?
                    status_id = issue.status.id if issue.status_id?
                    status = issue.status.name if issue.status_id?
                    # priority_id = issue.priority.id  if issue.priority_id?
                    # priority = issue.priority.name  if issue.priority_id?
                    # author_id = issue.author.id  if issue.author_id?
                    # author = issue.author.name  if issue.author_id?
                    # category_id = issue.category.id if issue.category_id?
                    # category = issue.category.name if issue.category_id?
                    assigned_to_id = issue.assigned_to.id  if issue.assigned_to_id?
                    assigned_to = issue.assigned_to.name  if issue.assigned_to_id?
                    due_date = issue.due_date
                    # closed_on = issue.closed_on
                    # issue_array[issue.id] = {"id": issue.id, "project": {"id": project_id, "name": project}, "tracker": {"id": tracker_id, "name": tracker}, "status": {"id": status_id, "name": status}, "priority": {"id": priority_id, "name": priority}, "author": {"id": author_id, "name": author}, "assigned_to": {"id": assigned_to_id, "name": assigned_to}, "category": {"id": category_id, "name": category}, "due_date": due_date, "closed_on": closed_on}
                    issue_array[issue.id] = {"id": issue.id, "tracker": {"id": tracker_id, "name": tracker}, "status": {"id": status_id, "name": status}, "assigned_to": {"id": assigned_to_id, "name": assigned_to}, "due_date": due_date}
                end
                issues_json = JSON.parse(issue_array.to_json)
                render json: {"issues": issues_json}
            end
        else
            logger.info("usuário não logado tentou acessar API")
            render json: {"error": "Usuário não logado"}, status: :unauthorized
        end
    end

    def issues_all_visible
        if User.current.logged?
            if request.get? 
                # issues = Issue.all.select('id,tracker_id,project_id,due_date,category_id,priority_id,author_id,assigned_to_id').group_by(&:assigned_to_id)
                issue_array = Hash.new
                issues = Issue.visible
                issues.each do |issue|
                    # project_id = issue.project_id if issue.project_id?
                    # project = issue.project.name if issue.project_id?
                    tracker_id = issue.tracker.id if issue.tracker_id?
                    tracker = issue.tracker.name if issue.tracker_id?
                    status_id = issue.status.id if issue.status_id?
                    status = issue.status.name if issue.status_id?
                    # priority_id = issue.priority.id  if issue.priority_id?
                    # priority = issue.priority.name  if issue.priority_id?
                    # author_id = issue.author.id  if issue.author_id?
                    # author = issue.author.name  if issue.author_id?
                    # category_id = issue.category.id if issue.category_id?
                    # category = issue.category.name if issue.category_id?
                    assigned_to_id = issue.assigned_to.id  if issue.assigned_to_id?
                    assigned_to = issue.assigned_to.name  if issue.assigned_to_id?
                    due_date = issue.due_date
                    # closed_on = issue.closed_on
                    # issue_array[issue.id] = {"id": issue.id, "project": {"id": project_id, "name": project}, "tracker": {"id": tracker_id, "name": tracker}, "status": {"id": status_id, "name": status}, "priority": {"id": priority_id, "name": priority}, "author": {"id": author_id, "name": author}, "assigned_to": {"id": assigned_to_id, "name": assigned_to}, "category": {"id": category_id, "name": category}, "due_date": due_date, "closed_on": closed_on}
                    issue_array[issue.id] = {"id": issue.id, "tracker": {"id": tracker_id, "name": tracker}, "status": {"id": status_id, "name": status}, "assigned_to": {"id": assigned_to_id, "name": assigned_to}, "due_date": due_date}
                end
                issues_json = JSON.parse(issue_array.to_json)
                render json: {"issues": issues_json}
            end
        else
            logger.info("usuário não logado tentou acessar API")
            render json: {"error": "Usuário não logado"}, status: :unauthorized
        end
    end
end

