require 'erb'

class MissingSpecGenerator

  def spec_file(spec_path, file_name, spec_template, namespace)
    spec_name = file_name.gsub('.rb', '') + '_spec.rb'
    if File.exist?("#{spec_path}/#{spec_name}")
      puts "#{spec_path}/#{spec_name} exists"
    else
      puts "#{spec_path}/#{spec_name} missing"
      puts "\n"
      spec_file = ERB.new(spec_template)
      class_name = "#{namespace}#{file_name.gsub('.rb', '').camelcase}"
      spec = spec_file.result(binding)
      puts spec
      FileUtils.mkdir_p(spec_path) unless File.exist?(spec_path)
      File.open("#{spec_path}/#{spec_name}", 'w') {|f| f.write(spec) }
      puts "\n"
    end
  end

  def traverse_specs(path, spec_template, namespace = '')
    Dir.open(RAILS_ROOT + '/app/' + path).each do |file_name|
      unless file_name.match(/^\./) #skip hidden folders (.svn)
        if File.directory?(RAILS_ROOT + '/app/' + path + '/' + file_name)
          traverse_specs("#{path}/#{file_name}", spec_template, "#{namespace}#{file_name.camelcase}::")
        else
          spec_file("#{RAILS_ROOT}/spec/#{path}", file_name, spec_template, namespace)
        end
      end
    end
  end

  def generate_missing_helper_specs
    helper_template = %q{require 'spec_helper'

      describe <%= class_name %> do

        #Delete this example and add some real ones or delete this file
        it "should be included in the object returned by #helper" do
          included_modules = (class << helper; self; end).send :included_modules
          included_modules.should include(<%= class_name %>Helper)
        end

      end
    }.gsub(/^      /, '')
    traverse_specs('helpers', helper_template)
  end

  def generate_missing_controller_specs
    controller_template = %q{require 'spec_helper'

      describe <%= class_name %> do

        #Delete this example and add some real ones
        it "should use <%= class_name %>" do
          controller.should be_an_instance_of(<%= class_name %>)
        end

      end
    }.gsub(/^      /, '')
    traverse_specs('controllers', controller_template)
  end

  def generate_missing_model_specs
    model_template = %q{require 'spec_helper'

      describe <%= class_name %> do
        before(:each) do
          @valid_attributes = { }
        end

        it "should create a new instance given valid attributes" do
          <%= class_name %>.create!(@valid_attributes)
        end
      end
    }.gsub(/^      /, '')
    traverse_specs('models', model_template)
  end

end
