#This requires all the methods to use instead of cucumber

def require_all_files_below(folder)
  Dir["#{folder}/**/*.rb"].each {|rb_file| require rb_file}
end
methods_folder = File.join(File.expand_path(File.dirname(__FILE__)),"lib_methods")
require_all_files_below(methods_folder)
