{ inputs, ... }:
{
  flake.modules.nixos.kanata =
    { ... }:
    {
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
              (deflayer qwerty
                grv  1    2    3    4    5    6    7    8    9    0    -    =
              	tab  q    w    e    r    t    y    u    i    o    p    [    ]
              	caps a    s    d    f    g    h    j    k    l    ;    '
              	lsft z    x    c    v    b    n    m    ,    .    /    rsft
              	lctl lmet lalt           spc            ralt @wrl rctl
              )
              (deflayer whirl
                _   _    _    _    _    _    _    _    _    _    _    _    _
              	_    b    g    d    f    v     z   l    u    o    y  _    _
               C-bspc n    s    t    h    m    '    r    e    a    i    /
              	_         c    p    w    k  q  x    j    ;    .    ,    _
              	_    lalt      @met               _            @*  @qwr _
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
              	nav (layer-while-held nav)
              	alt (multi alt(layer-while-held qwerty))
              	met (multi met(layer-while-held qwerty))
              	* (switch
              		((key-history w 1)) h break
              		((key-history y 1)) , break
              		((key-history u 1)) e break
              		((key-history g 1)) s break
              		((key-history ' 1)) r break
              		() rpt break)
              	)
            '';
          };
        };
      };
    };
}
