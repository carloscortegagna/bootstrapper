namespace :vim do

    task :install => [:janus_install]

    task :janus_install do
        target = "#{$home}/.vim"
        dotgit = "#{target}/.git"
        janusrepo = 'https://github.com/carlhuda/janus.git'

        if (File.exists?(target) && File.exists?(dotgit) )
            remote_url = `cd #{target}; git remote -v | grep fetch | awk '{print $2}'`.chomp
            if remote_url == janusrepo
                puts "*** bootstrapper: .vim is already part of janus, updating"
                Rake::Task["vim:janus_update"].execute   
            end
        else
            system "curl -Lo- http://bit.ly/janus-bootstrap | bash"
        end
    end
    
    task :janus_update do
        FileUtils.cd "#{$home}/.vim"
        system "rake"
    end

end

