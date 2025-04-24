{lib, ...}: {
    virtualisation.waydroid.enable = true;
    systemd.services.waydroid-container.wantedBy = lib.mkForce [];
}
