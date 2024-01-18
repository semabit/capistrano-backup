def move_archive_files
  filenames = capture(:ls, '*.tar').split(' ')
  # could be multiple files, move all of them into backup dir
  filenames.each do |filename|
    filename = filename.strip
    execute :mkdir, '-p', '../../../backups'
    execute :mv, "#{filename} ../../../backups/#{Time.now.strftime('%Y%m%d%H%M%S')}_#{filename}"
  end
end

def creates_database_backup?
  !fetch(:backup_skip_database, false)
end

def creates_uploads_backup?
  !fetch(:backup_skip_uploads, false)
end

def creates_backup?
  creates_database_backup? || creates_uploads_backup?
end

desc 'Create Backup'
task :create_backup do
  on roles(:app), in: :sequence, wait: 5 do
    within current_path do
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
        move_archive_files
      end
    end
  end
end

desc 'Create backup files'
task :create_backup_files do
  on roles(:app), in: :sequence, wait: 5 do
    within current_path do
      with rails_env: fetch(:rails_env) do
        set :backup_dir_path, capture(:pwd)

        if creates_backup?
          execute(:rake, "backup:create:backup_dir")
          execute(:rake, "backup:create:db") if creates_database_backup?
          execute(:rake, "backup:create:uploads") if creates_uploads_backup?
        end
      end
    end
  end
end

desc 'Archive backup files'
task :archive_backup do
  on roles(:app), in: :sequence, wait: 5 do
    backup_dir_path = fetch(:backup_dir_path, release_path)

    within backup_dir_path do
      with rails_env: fetch(:rails_env) do
        if creates_backup?
          execute(:rake, "backup:create:tarball output_file=#{fetch(:backup_filename)}")
          move_archive_files
        end
      end
    end
  end
end
