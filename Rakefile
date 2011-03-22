
task :link_files do
  ["janus.rake","bashrc"].each do |file| 
      dest = File.expand_path("~/.#{file}")
      unless File.exist?(dest) 
         ln_s(File.expand_path("../#{file}", __FILE__), dest)
      end
  end
end 


task :default =>[:link_files]
