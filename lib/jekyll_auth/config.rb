class JekyllAuth
  def self.config_file
    File.join(Dir.pwd, '_config.yml')
  end

  def self.jekyll_config
    @config ||= begin
      jekyll_config = YAML.safe_load_file(config_file)
    end
  end

  def self.destination
      JekyllAuth.jekyll_config['destination'] || '_site'

  end

  def self.config
      JekyllAuth.jekyll_config['jekyll_auth'] || {}

  end

  def self.whitelist
    whitelist = JekyllAuth.jekyll_config['whitelist']
    Regexp.new(whitelist.join('|')) unless whitelist.nil?
  end

  def self.ssl?
    !!JekyllAuth.config['ssl']
  end
end