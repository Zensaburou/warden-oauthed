group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: "bundle exec rspec", failed_mode: 'focus' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  end
  # guard :rubocop, all_on_start: false do
  #   watch(/.+\.rb$/)
  #   watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  # end
end
