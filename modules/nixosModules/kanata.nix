{
  flake.modules.nixos.kanata = {
    services.kanata = {
      enable = true;
      keyboards = {
        laptop = {
          devices = [ ];
          config = ''
            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =
            	tab  q    w    e    r    t    y    u    i    o    p    [    ]
            	caps a    s    d    f    g    h    j    k    l    ;    '
            	lsft z    x    c    v    b    n    m    ,    .    /    rsft
            	lctl lmet lalt           spc            ralt menu rctl
            )
            (deflayer whirl
              _   _    _    _    _    _    _    _    _    _    _    _    _
            	_    b    g    d    f    v     z   l    u    o    y  _    _
             C-bspc n    s    t    h    m    '    r    e    a    i    /
            	_         c    p    w    k  q  x    j    ;    .    ,    _
            	_    lalt      @met               _            @*  @chg _
            )
            (deflayer chog2
              _   _    _    _    _    _    _    _    _    _    _    _    _
            	_    b    k    l    c    p     z   y    o    h    ,  _    _
             C-bspc n    t    r    d    m    '    s    a    e    i    /
            	_         v    j    g    w  x  q    f    u    ;    .    _
            	_    lalt      @met               _            @*  @qwr _
            )
            (deflayer qwerty
              grv  1    2    3    4    5    6    7    8    9    0    -    =
            	tab  q    w    e    r    t    y    u    i    o    p    [    ]
            	caps a    s    d    f    g    h    j    k    l    ;    '
            	lsft z    x    c    v    b    n    m    ,    .    /    rsft
            	lctl lmet lalt           spc            ralt @wrl rctl
            )
            (deflayer nav
            	_    _    _    _    _    _    _    _    _    _    _    _    _
            	_    _    _    _    _    _    _    _    _    _    _    _    _
            	_    _    _    _    _    _    left down up  right _    _
            	_    _    _    _    _    _    _    _    _    _    _    _
            	_    _    _              _              _    _    _
            )
            (defalias
            	qwr (layer-switch qwerty)
            	wrl (layer-switch whirl)
            	chg (layer-switch chog2)
            	nav (layer-while-held nav)
            	alt (multi alt(layer-while-held qwerty))
            	met (multi met(layer-while-held qwerty))
            	*w (switch
            		((key-history w 1)) h break
            		((key-history y 1)) , break
            		((key-history u 1)) e break
            		((key-history g 1)) s break
            		((key-history ' 1)) r break
            		() rpt break)
            	)
            	*c (switch
            		((key-history ' 1)) s break
            		((key-history a 1)) u break
            		((key-history b 1)) l break
            		((key-history g 1)) l break
            		((key-history h 1)) e break
            		((key-history m 1)) p break
            		((key-history o 1)) u break
            		((key-history u 1)) a break
            		((key-history w 1)) l break
            		((key-history y 1)) s break
            		() rpt break)
            	)
          '';
        };
      };
    };
  };
}
