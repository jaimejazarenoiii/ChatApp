require 'xcodeproj'
project_path = 'ChatApp.xcodeproj'
project = Xcodeproj::Project.open(project_path)

def addFiles (direc, group, project)
    new_group = project.main_group.find_subpath(File.join(direc, group))
    google_config_plist_pathname = Pathname.new(File.expand_path("#{direc}/#{group}/GoogleService-Info.plist"))
    file_ref = new_group.files.find do |file| 
      file.real_path == google_config_plist_pathname
    end
    unless file_ref
      j = new_group.new_file(google_config_plist_pathname)
    end
end

addFiles("ChatApp/", "Supporting Files",  project)

project.save
