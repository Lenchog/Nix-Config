{
  specialArgs,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    import
    ./disko.nix
    { device = "/dev/nvme0n1"; }
  ];

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.lenny = {
      directories = [
        "nix"
        "home"
        "steam"
        ".mozilla"
      ];
      files = [ "zsh_history" ];
      home = "/home/lenny";
    };
  };
  boot.initrd.postDeviceCommands = ''
            mkdir /btrfs_tmp
            mount /dev/root_vg/root /btrfs_tmp
            if [[ -e /btrfs_tmp/root ]]; then
            	mkdir -p /btrfs_tmp/old_roots
            	timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%h:%M:%S")
            	mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
            fi

            delete_subvolume_recursively() {
            	IFS=$'\n'
            	for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            		delete_subvolume_recursively "/btrfs_tmp/$i"
            	done
            	btrfs subvolume delete "$1"
            }

            for i in $(find /btrfs_tmp/old-roots/ -maxdepth 1 -mtime +30); do
            	delete_subvolume_recursively "$i"
            done
            btrfs subvolume create /btrfs_tmp/root
            umount /btrfs_tmp
    	'';
}
