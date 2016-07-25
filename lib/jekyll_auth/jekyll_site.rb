class JekyllAuth
  class JekyllSite < Sinatra::Base
    register Sinatra::Index
    destination = JekyllAuth.destination
    puts destination['destination'].inspect
    set :public_folder, File.expand_path('_site', Dir.pwd)
    use_static_index 'index.html'

    # Rewrite calls to .html files if they exist.
    get '/:path' do
      file = File.join(File.expand_path(settings.public_folder, Dir.pwd), "#{params['path']}.html")
      if File.exists?(file)
        File.read(file)
      else
        not_found
      end
    end

    not_found do
      status 404
      four_oh_four = File.expand_path(settings.public_folder + '/404.html', Dir.pwd)
      File.read(four_oh_four) if File.exist?(four_oh_four)
    end
  end
end
