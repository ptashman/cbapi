class ScopeGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :resource_name, type: :string
  argument :scope_name, type: :string

  def generate_scoped_route
    resources_line = /resources :#{Regexp.quote(group_name)}, except: \[:new, :edit\]/i
    in_root do
      inject_into_file 'config/routes.rb', scoped_route, after: resources_line, verbose: false
    end
  end

  def generate_scoped_action
    private_line = /private/i
    in_root do
      inject_into_file "app/controllers/#{group_name}_controller.rb", scoped_action, before: private_line, verbose: false
    end
  end

  def generate_scope
    class_line = /class #{resource_name.singularize.camelcase} < ActiveRecord::Base/
    in_root do
      inject_into_file "app/models/#{resource_name.singularize.underscore}.rb", scope, after: class_line, verbose: false
    end
  end

  private

  def group_name
    resource_name.pluralize.underscore
  end

  def scoped_route
    "\n  get '#{scope_name.downcase}_#{group_name}', to: '#{group_name}#scoped', scope: :#{scope_name.downcase}"
  end

  def scoped_action
    "  # GET /#{scope_name.downcase}_#{group_name}\n  # GET /#{scope_name.downcase}_#{group_name}.json\n  def scoped
    @#{scope_name.downcase}_#{group_name} = #{resource_name.singularize.camelcase}.send(params[:scope])
    \n    render json: @#{scope_name.downcase}_#{group_name}\n  end\n\n"
  end

  def scope
    "\n  scope :#{scope_name.downcase}, -> { all } #Add your constraints here."
  end
end
