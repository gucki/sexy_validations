# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sexy_validations}
  s.version = "0.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Corin Langosch"]
  s.date = %q{2010-11-24}
  s.description = %q{Module which provides sexy validations for models.}
  s.email = %q{info@netskin.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/sexy_validations.rb",
    "lib/sexy_validations/errors.rb",
    "lib/sexy_validations/validators/acceptance.rb",
    "lib/sexy_validations/validators/age.rb",
    "lib/sexy_validations/validators/confirmation.rb",
    "lib/sexy_validations/validators/count.rb",
    "lib/sexy_validations/validators/date.rb",
    "lib/sexy_validations/validators/email.rb",
    "lib/sexy_validations/validators/file.rb",
    "lib/sexy_validations/validators/format.rb",
    "lib/sexy_validations/validators/image.rb",
    "lib/sexy_validations/validators/inclusion.rb",
    "lib/sexy_validations/validators/length.rb",
    "lib/sexy_validations/validators/password.rb",
    "lib/sexy_validations/validators/presence.rb",
    "sexy_validations.gemspec",
    "spec/sequel_sexy_validations_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/gucki/sexy_validations}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Sexy validations for Models}
  s.test_files = [
    "spec/sequel_sexy_validations_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

