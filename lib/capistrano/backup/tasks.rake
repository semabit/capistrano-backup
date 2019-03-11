desc 'Create Backup'
task :create_backup do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      with rails_env: fetch(:rails_env) do
        arguments = {
          output_file: fetch(:backup_filename),
          skip_database: fetch(:backup_skip_database, false),
          skip_uploads: fetch(:backup_skip_uploads, false),
        }.map { |name, value| [name, value.to_s.strip] }
          .reject { |(_, value)| value.empty? }
          .map { |(name, value)| "#{name}=#{value}" }
          .join(" ")

        execute(:rake, "backup:create #{arguments}")

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
