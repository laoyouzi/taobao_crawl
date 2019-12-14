Sidekiq.configure_server do |config|
  config.redis = {url: 'redis://127.0.0.1:6379', namespace: Rails.application.class.parent_name.downcase + 'sidekiq'}
end

Sidekiq.configure_client do |config|
  config.redis = {url: 'redis://127.0.0.1:6379', namespace: Rails.application.class.parent_name.downcase + 'sidekiq'}
end
