require 'spec/rake/spectask'

require 'echoe'
Echoe.new 'versionable' do |p|
  p.description     = "Simple versioning for Ruby objects using only the Rails cache."
  # p.url             = "http://versionable.rubyforge.org"
  p.author          = "Elijah Miller"
  p.email           = "elijah.miller@gmail.com"
  p.retain_gemspec  = true
  p.need_tar_gz     = false
  p.extra_deps      = [
  ]
end

desc 'Default: run specs'
task :default => :spec
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList["spec/**/*_spec.rb"]
end

task :test => :spec
