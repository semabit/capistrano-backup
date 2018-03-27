desc 'Create Backup'
task :create_backup do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      with rails_env: fetch(:rails_env) do
        if fetch(:backup_filename).to_s.strip.empty?
          execute :rake, 'backup:create'
        else
          execute :rake, "backup:create output_file=#{fetch(:backup_filename)}"
        end
        filenames = capture(:ls, '*.tar').split(' ')
        # could be multiple files, move all of them into backup dir
        filenames.each do |filename|
          filename = filename.strip
          execute :mkdir, '-p', '../../../backups'
          execute :mv, "#{filename} ../../../backups/#{Time.now.strftime('%Y%m%d%H%M%S')}_#{filename}"
        end
      end
    end
  end
end
