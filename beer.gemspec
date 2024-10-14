# frozen_string_literal: true

require_relative "lib/beer/version"

Gem::Specification.new do |spec|
  spec.name = "beer"
  spec.version = Beer::VERSION
  spec.authors = ["Dmitry Melkunas"]
  spec.email = ["dmitry.melkunas@ecomcharge.com"]

  spec.version = "0.1.0"
  spec.date = "2024-09-27"
  spec.summary = "BeER client for communication with other services"
  spec.description = "BeER client for communication with other services"
  spec.homepage = "https://github.com/begateway/beer_client"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/begateway/beer_client"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.rubygems_version = "3.2.3".freeze
  spec.installed_by_version = "3.2.3" if spec.respond_to? :installed_by_version

  if spec.respond_to? :add_runtime_dependency then
    spec.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
    spec.add_runtime_dependency(%q<faraday>.freeze, [">= 0"])
    spec.add_runtime_dependency(%q<faraday_middleware>.freeze, [">= 0"])
    spec.add_development_dependency(%q<bundler>.freeze, ["~> 2.4.13"])
    spec.add_development_dependency(%q<rake>.freeze, ["~> 12.3.3"])
    spec.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    spec.add_development_dependency(%q<pry>.freeze, [">= 0"])
    spec.add_development_dependency(%q<webmock>.freeze, [">= 0"])
  else
    spec.add_dependency(%q<activesupport>.freeze, [">= 0"])
    spec.add_dependency(%q<faraday>.freeze, [">= 0"])
    spec.add_dependency(%q<faraday_middleware>.freeze, [">= 0"])
    spec.add_dependency(%q<bundler>.freeze, ["~> 2.4.13"])
    spec.add_dependency(%q<rake>.freeze, ["~> 12.3.3"])
    spec.add_dependency(%q<rspec>.freeze, [">= 0"])
    spec.add_dependency(%q<pry>.freeze, [">= 0"])
    spec.add_dependency(%q<webmock>.freeze, [">= 0"])
  end
end
