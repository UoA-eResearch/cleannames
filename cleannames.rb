#!/usr/bin/ruby
require 'fileutils'

REPLACEMENT = 'X'
DOT_REPLACEMENT = '_'

def clean_filename(file:)
  #remove leading and trailin spaces and substitute X for special characters
  new_file = file.strip.gsub(/~|\"|\'|#|%|\&|\*|:|\<|\>|\?|\/|\\|\{|\||\}/, REPLACEMENT)
  new_file_prefix = nil #Just so we can reference it later
  
  #look for multiple '.'s in a file and replace all but the last with an _
  tokens = new_file.split('.')
  if tokens.length > 1
    new_file_prefix = tokens[0...-1].join('_')
    new_file =  "#{new_file_prefix}.#{tokens[-1]}" 
  end
  
  if(file != new_file)
    #The file name changed, so check that the new file name doesn't already exist
    new_file_base = new_file
    index = 1
    while(File.exist?(new_file))
      #Add numeric index to the end of the file name (before the '.')
      if tokens.length > 1
        new_file =  "#{new_file_prefix}_#{index}.#{tokens[-1]}"
      else
        new_file = "#{new_file_base}_#{index}"
      end
      index += 1
    end
    
    puts "renaming '#{file}' to '#{new_file}'"
    FileUtils.mv(file, "./#{new_file}")
  end
  return new_file
end

def rename_directory(directory:)
  # use a persistent connection to transfer files
  begin
    Dir.chdir directory
    puts "In #{directory}"
    Dir.open('.').each do |filename|
      if filename != '.' && filename != '..'
        # ignore the current and previous dir entries.
        new_filename = clean_filename(file: filename )
        if File.directory?(new_filename)
          # Recurse through sub directories
          rename_directory(directory: new_filename)
          puts "Back In #{directory}"
        end
      end
    end
  rescue Exception => error
    puts "#{error}"
  ensure
    Dir.chdir '..'
  end
end


foldername = `osascript -e 'tell application "System Events" to activate' -e 'tell application "System Events" to return POSIX path of (choose folder with prompt "select an image file ")'`.chomp
if foldername != nil && foldername != ''
  rename_directory(directory: foldername)
end

