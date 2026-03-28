{
  flake.modules.homeManager.lf =
    { pkgs, ... }:
    {
      programs.lf = {
        enable = true;
        settings = {
          preview = true;
          drawbox = true;
          icons = true;
          ignorecase = true;
        };
        commands = {
          mkdir =
            # bash
            ''
              ''${{
              	printf "Directory Name: "
              	read ans
              	mkdir $ans
              }}
            '';
          mkfile =
            # bash
            ''
              ''${{
              	printf "File Name: "
              	read ans
              	$EDITOR $ans
              }}
            '';
          trash =
            # bash
            ''
              ''${{
              	${pkgs.trashy}/bin/trash "$f"
              }}
            '';
          restore-trash =
            # bash
            ''
              ''${{
              	${pkgs.trashy}/bin/trash restore
              }}'';
          open-editor =
            # bash
            "$$EDITOR $f";
          find-dir =
            # bash
            ''$lf -remote "send $id cd $(${pkgs.fd}/bin/fd . ~ --type d | ${pkgs.fzf}/bin/fzf)"'';
          unarchive =
            # bash
            ''
              ''${{
              	case "$f" in
              		*.zip) ${pkgs.unzip}/bin/unzip "$f" ;;
              		*.tar.gz) ${pkgs.gnutar}/bin/tar -xzvf "$f";;
              		*.tar.bz2) ${pkgs.gnutar}/bin/tar -xjvf "$f";;
              		*.tar) ${pkgs.gnutar}/bin/tar -xvf "$f";;
              		*.7z) ${pkgs.p7zip}/bin/7z e "$f";;
              		*) echo "Unsupported format" ;;
              	esac
              }}
            '';
        };
        keybindings = {
          "<enter>" = "open";
          o = "mkfile";
          O = "mkdir";
          "." = "set hidden!";
          "gd" = "cd ~/Downloads";
          "gn" = "cd ~/nix";
          "au" = "unarchive";
          d = "";
          x = "cut";
          y = "copy";
          "dd" = "trash";
          "dr" = "restore-trash";
          f = "find-dir";
        };
        extraConfig =
          let
            previewer = pkgs.writeShellScriptBin "preview.sh" ''
                file=$1
                w=$2
                h=$3
                x=$4
                y=$5

                if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
                    ${pkgs.kitty}/bin/kitty +kitten icat --transfer-mode file --stdin no --place "''${w}x''${h}@''${x}x''${y}" "''$file" < /dev/null > /dev/tty
              #kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
                    exit 1
                fi

                ${pkgs.pistol}/bin/pistol "$file"
            '';
            cleaner = pkgs.writeShellScriptBin "clean.sh" ''
              ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
            '';
          in
          ''
            set cleaner ${cleaner}/bin/clean.sh
            set previewer ${previewer}/bin/preview.sh
          '';
      };
      xdg.configFile."lf/icons".text = ''
        # vim:ft=conf

        # These examples require Nerd Fonts or a compatible font to be used.
        # See https://www.nerdfonts.com for more information.

        # default values from lf (with matching order)
        # ln      l       # LINK
        # or      l       # ORPHAN
        # tw      t       # STICKY_OTHER_WRITABLE
        # ow      d       # OTHER_WRITABLE
        # st      t       # STICKY
        # di      d       # DIR
        # pi      p       # FIFO
        # so      s       # SOCK
        # bd      b       # BLK
        # cd      c       # CHR
        # su      u       # SETUID
        # sg      g       # SETGID
        # ex      x       # EXEC
        # fi      -       # FILE

        # file types (with matching order)
        ln             # LINK
        or             # ORPHAN
        tw      t       # STICKY_OTHER_WRITABLE
        ow             # OTHER_WRITABLE
        st      t       # STICKY
        di             # DIR
        pi      p       # FIFO
        so      s       # SOCK
        bd      b       # BLK
        cd      c       # CHR
        su      u       # SETUID
        sg      g       # SETGID
        ex             # EXEC
        fi             # FILE

        # file extensions (vim-devicons)
        *.styl          
        *.sass          
        *.scss          
        *.htm           
        *.html          
        *.slim          
        *.haml          
        *.ejs           
        *.css           
        *.less          
        *.md            
        *.mdx           
        *.markdown      
        *.rmd           
        *.json          
        *.webmanifest   
        *.js            
        *.mjs           
        *.jsx           
        *.rb            
        *.gemspec       
        *.rake          
        *.php           
        *.py            
        *.pyc           
        *.pyo           
        *.pyd           
        *.coffee        
        *.mustache      
        *.hbs           
        *.conf          
        *.ini           
        *.yml           
        *.yaml          
        *.toml          
        *.bat           
        *.mk            
        *.jpg           
        *.jpeg          
        *.bmp           
        *.png           
        *.webp          
        *.gif           
        *.ico           
        *.twig          
        *.cpp           
        *.c++           
        *.cxx           
        *.cc            
        *.cp            
        *.c             
        *.cs            󰌛
        *.h             
        *.hh            
        *.hpp           
        *.hxx           
        *.hs            
        *.lhs           
        *.nix           
        *.lua           
        *.java          
        *.sh            
        *.fish          
        *.bash          
        *.zsh           
        *.ksh           
        *.csh           
        *.awk           
        *.ps1           
        *.ml            λ
        *.mli           λ
        *.diff          
        *.db            
        *.sql           
        *.dump          
        *.clj           
        *.cljc          
        *.cljs          
        *.edn           
        *.scala         
        *.go            
        *.dart          
        *.xul           
        *.sln           
        *.suo           
        *.pl            
        *.pm            
        *.t             
        *.rss           
        '*.f#'          
        *.fsscript      
        *.fsx           
        *.fs            
        *.fsi           
        *.rs            
        *.rlib          
        *.d             
        *.erl           
        *.hrl           
        *.ex            
        *.exs           
        *.eex           
        *.leex          
        *.heex          
        *.vim           
        *.ai            
        *.psd           
        *.psb           
        *.ts            
        *.tsx           
        *.jl            
        *.pp            
        *.vue           
        *.elm           
        *.swift         
        *.xcplayground  
        *.tex           󰙩
        *.r             󰟔
        *.rproj         󰗆
        *.sol           󰡪
        *.pem           

        # file names (vim-devicons) (case-insensitive not supported in lf)
        *gruntfile.coffee       
        *gruntfile.js           
        *gruntfile.ls           
        *gulpfile.coffee        
        *gulpfile.js            
        *gulpfile.ls            
        *mix.lock               
        *dropbox                
        *.ds_store              
        *.gitconfig             
        *.gitignore             
        *.gitattributes         
        *.gitlab-ci.yml         
        *.bashrc                
        *.zshrc                 
        *.zshenv                
        *.zprofile              
        *.vimrc                 
        *.gvimrc                
        *_vimrc                 
        *_gvimrc                
        *.bashprofile           
        *favicon.ico            
        *license                
        *node_modules           
        *react.jsx              
        *procfile               
        *dockerfile             
        *docker-compose.yml     
        *rakefile               
        *config.ru              
        *gemfile                
        *makefile               
        *cmakelists.txt         
        *robots.txt             󰚩

        # file names (case-sensitive adaptations)
        *Gruntfile.coffee       
        *Gruntfile.js           
        *Gruntfile.ls           
        *Gulpfile.coffee        
        *Gulpfile.js            
        *Gulpfile.ls            
        *Dropbox                
        *.DS_Store              
        *LICENSE                
        *React.jsx              
        *Procfile               
        *Dockerfile             
        *Docker-compose.yml     
        *Rakefile               
        *Gemfile                
        *Makefile               
        *CMakeLists.txt         

        # file patterns (vim-devicons) (patterns not supported in lf)
        # .*jquery.*\.js$         
        # .*angular.*\.js$        
        # .*backbone.*\.js$       
        # .*require.*\.js$        
        # .*materialize.*\.js$    
        # .*materialize.*\.css$   
        # .*mootools.*\.js$       
        # .*vimrc.*               
        # Vagrantfile$            

        # file patterns (file name adaptations)
        *jquery.min.js          
        *angular.min.js         
        *backbone.min.js        
        *require.min.js         
        *materialize.min.js     
        *materialize.min.css    
        *mootools.min.js        
        *vimrc                  
        Vagrantfile             

        # archives or compressed (extensions from dircolors defaults)
        *.tar   
        *.tgz   
        *.arc   
        *.arj   
        *.taz   
        *.lha   
        *.lz4   
        *.lzh   
        *.lzma  
        *.tlz   
        *.txz   
        *.tzo   
        *.t7z   
        *.zip   
        *.z     
        *.dz    
        *.gz    
        *.lrz   
        *.lz    
        *.lzo   
        *.xz    
        *.zst   
        *.tzst  
        *.bz2   
        *.bz    
        *.tbz   
        *.tbz2  
        *.tz    
        *.deb   
        *.rpm   
        *.jar   
        *.war   
        *.ear   
        *.sar   
        *.rar   
        *.alz   
        *.ace   
        *.zoo   
        *.cpio  
        *.7z    
        *.rz    
        *.cab   
        *.wim   
        *.swm   
        *.dwm   
        *.esd   

        # image formats (extensions from dircolors defaults)
        *.jpg   
        *.jpeg  
        *.mjpg  
        *.mjpeg 
        *.gif   
        *.bmp   
        *.pbm   
        *.pgm   
        *.ppm   
        *.tga   
        *.xbm   
        *.xpm   
        *.tif   
        *.tiff  
        *.png   
        *.svg   
        *.svgz  
        *.mng   
        *.pcx   
        *.mov   
        *.mpg   
        *.mpeg  
        *.m2v   
        *.mkv   
        *.webm  
        *.ogm   
        *.mp4   
        *.m4v   
        *.mp4v  
        *.vob   
        *.qt    
        *.nuv   
        *.wmv   
        *.asf   
        *.rm    
        *.rmvb  
        *.flc   
        *.avi   
        *.fli   
        *.flv   
        *.gl    
        *.dl    
        *.xcf   
        *.xwd   
        *.yuv   
        *.cgm   
        *.emf   
        *.ogv   
        *.ogx   

        # audio formats (extensions from dircolors defaults)
        *.aac   
        *.au    
        *.flac  
        *.m4a   
        *.mid   
        *.midi  
        *.mka   
        *.mp3   
        *.mpc   
        *.ogg   
        *.ra    
        *.wav   
        *.oga   
        *.opus  
        *.spx   
        *.xspf  

        # other formats
        *.pdf   
      '';
    };
}
