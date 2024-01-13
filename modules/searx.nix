{ lib, ... }:
{
	services.searx = {
		enable = true;    
		settings = {
			general = {
				instance_name = "Lenny's epic search engine";
			};
      server = {
        port = 8888;
        bind_address = "127.0.0.1";
        secret_key = "secretkey";
      };
			search = {
				safe_search = 2;
				autocomplete = "duckduckgo";
				#public_instance = true;
    	};
			ui = {
				infinite_scroll = true;
				center_alignment = true;
				hotkeys = "vim";
			};
			engines = [
			{ name = "duckduckgo";
				disabled = true;
			}
			{ name = "qwant";
				disabled = true;
			}
			{ name = "wikidata";
				disabled = true;
			}
			{ name = "lingva";
				disabled = true;
			}
			{
				name = "dictzone";
				disabled = true;
			}
			];
		};
	};
}
