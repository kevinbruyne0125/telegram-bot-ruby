# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'bundler/setup'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = false
  task.options = %w[--force-exclusion]
  task.patterns = %w[{lib,spec}/**/*.rb Rakefile]
  task.requires << 'rubocop-rspec'
end

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Dump type definitions from docs to YAML'
task :dump_type_attributes do
  require File.expand_path('lib/telegram/bot', __dir__)
  require 'nokogiri'
  require 'open-uri'
  require 'yaml'

  # Preload every type we have
  Zeitwerk::Loader.eager_load_all
  types = Telegram::Bot::Types::Base.descendants.map { |c| c.name.split('::').last }

  # Fetch and parse docs
  doc = Nokogiri::HTML(URI.open('https://core.telegram.org/bots/api').read)

  result = types.to_h do |type|
    # This is very hacky but working way to find table containing attributes for
    # given type. Basic idea is to find heading with type and then iterate until
    # we find table with attributes or next heading (because sometimes type
    # doesn't have any attributes).
    element = doc.at_xpath(%{//h4[text() = "#{type}"]})
    loop do
      element = element.next_element
      break if %w[table h4].include?(element.name)
    end

    attributes = element.xpath('.//tbody//tr').map do |el|
      cells = el.children.select { |c| c.name == 'td' }
      {
        'name' => cells[0].text,
        'required' => !cells[2].text.start_with?('Optional.')
      }
    end

    [type, attributes]
  end

  # Write everything to fixture file
  File.write(
    File.expand_path('spec/fixtures/type_attributes.yml', __dir__),
    result.to_yaml
  )
end
