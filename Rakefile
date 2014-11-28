# -*- mode: ruby; coding: utf-8 -*-
require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/clean'
require 'date'

#############################################################################
#  Helper functions
#############################################################################
def name
  @name  ||= Dir['*.gemspec'].first.split('.').first
end

def version
  version = 0.1
  return version
end

def date
  Date.today.to_s
end

def gemspec_file
  "#{name}.gemspec"
end

def gem_file
  "#{name}-#{version}.gem"
end

def replace_header(head, header_name)
  head.sub!(/(\.#{header_name}\s*= ').*'/) { "#{$1}#{send(header_name)}'"}
end

desc "default => clobber"
task :default => :clobber
desc "distclean => clobber"
task :distclean => :clobber

desc "Create tag v#{version} and build and push #{gem_file} to Rubygems"
task :release => :build do
  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  sh "git commit --allow-empty -a -m 'Release #{version}'"
  sh "git tag v#{version}"
  sh "git push origin master"
  sh "git push origin v#{version}"
  sh "gem push pkg/#{name}-#{version}.gem"
end

desc "Generate #{gem_file}"
task :build => :gemspec  do
  sh "mkdir -p pkg"
  sh "gem build #{gemspec_file}"
  sh "mv #{gem_file} pkg/"
end

desc "Update #{gemspec_file}"
task :gemspec do
  spec = File.read(gemspec_file)
  head, manifest, tail = spec.split("  # = MANIFEST =\n")
  replace_header(head, :name)
  replace_header(head, :version)
  replace_header(head, :date)
  files = `git ls-files`.split("\n").sort.
    reject {|file| file =~/^\./}.
    reject {|file| file =~/^(rdoc|pkg)/}.
    map {|file| "    #{file}" }.
    join("\n")
  manifest = "  s.files = %w[\n#{files}\n  ]\n"
  spec = [head, manifest, tail].join("  # = MANIFEST =\n")
  File.open(gemspec_file, 'w'){ |io| io.write(spec)}
  puts "Update #{gemspec_file}"
end
