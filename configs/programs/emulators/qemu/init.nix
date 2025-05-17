{
    pkgs,
    inputs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        qemu
        inputs.qemu-launcher.packages."${pkgs.system}".default
    ];
}
