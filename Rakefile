desc "Rename everything."
task :setup, :name do |t, args|

    if ENV["PHASER"]
        phaser
    end

    if ENV["PIXI"]
        pixi
    end

    app_name = args[:name]

    files_to_modify = `grep -lir APP_NAME_LOWER .`.split "\n"
    files_to_modify = files_to_modify.reject {|s| s.include? "Rakefile" }

    files_to_modify.each do |s| 
        change_stuff_in_file s, "APP_NAME_LOWER", app_name.downcase
    end

    files_to_modify = `grep -lir APP_NAME .`.split "\n"
    files_to_modify = files_to_modify.reject {|s| s.include? "Rakefile" }

    files_to_modify.each do |s| 
        change_stuff_in_file s, "APP_NAME", app_name
    end

    `rm -fr *-e`
    `rm -fr src/*-e`
    #rename the entry point coffeescript file to the app title
    `mv src/app/entry_point.coffee src/app/#{app_name.downcase}.coffee`
    #remove the skeleton remote so this can be hacked on like a champ
    unless ENV['NORM']
    `rm -fr .git` 
    end
end

desc "Startup python server"
task :run do
    puts "Serving on port 8000!"
    `python -m SimpleHTTPServer` 
end


def phaser
    `wget 'https://raw.github.com/photonstorm/phaser/master/build/phaser.js' -O lib/phaser.js`
    add_script_to_index "phaser.js"
end

def pixi
    `wget 'https://raw.github.com/GoodBoyDigital/pixi.js/master/bin/pixi.dev.js' -O lib/pixi.dev.js`
    add_script_to_index "pixi.dev.js"
end

def change_stuff_in_file file, from, to
    f = File.open(file) 

    lines = f.readlines
    lines.map! { |line| line.gsub from, to }
    f.close

    f = File.new file, "w"
    lines.each { |l| f << l }
    f.close
end

def add_script_to_index script_name
    f = File.open("index.html")
    lines = f.readlines
    pl_index = 0

    lines.each_with_index{ |line, index| pl_index = index if line.include? "this is where the magic happens" }

    if pl_index == 0
       puts "magic not found, quitting." 
       exit 1
    end

    script_tag = "<script type=\"text/javascript\" src=\"#{ "lib/" + script_name }\"></script>\n"

    lines.insert pl_index, script_tag

    f = File.new "index.html", "w"
    lines.each { |l| f << l }

    f.close
end
