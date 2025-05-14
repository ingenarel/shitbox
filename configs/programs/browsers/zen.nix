{
    inputs,
    pkgs,
    ...
}: {
    home-manager.users.ingenarel = {
        imports = [
            inputs.zen-browser.homeModules.twilight
        ];
        programs.zen-browser = {
            enable = true;
            # find more options here: https://mozilla.github.io/policy-templates/
            policies = {
                DisableAppUpdate = true;
                DisableTelemetry = true;
                AutofillAddressEnabled = false;
                AutofillCreditCardEnabled = false;
                DisableFirefoxStudies = true;
                DisablePocket = true;
                DontCheckDefaultBrowser = true;
                NoDefaultBookmarks = false;
                OfferToSaveLogins = false;
            };
            profiles.default = {
                bookmarks = {
                    force = true;
                    settings = [
                        {
                            name = "archwiki";
                            url = "https://wiki.archlinux.org";
                        }
                        {
                            name = "gentoowiki";
                            url = "https://wiki.gentoo.org";
                        }
                        {
                            name = "nixwiki";
                            url = "https://wiki.nixos.org";
                        }
                        {
                            name = "github";
                            url = "https://github.com";
                        }
                        {
                            name = "gitlab";
                            url = "https://gitlab.com";
                        }
                        {
                            name = "youtube";
                            url = "https://www.youtube.com";
                        }
                        {
                            name = "home manager options";
                            url = "https://home-manager-options.extranix.com";
                        }
                        {
                            name = "nixos search";
                            url = "https://search.nixos.org/packages";
                        }
                    ];
                };
                extensions = {
                    force = true;
                    packages = with inputs.firefox-addons.packages."${pkgs.system}"; [
                        keepassxc-browser
                        vimium
                        proton-vpn
                        ublock-origin
                    ];
                };
                settings = {
                    "extensions.autoDisableScopes" = 0;
                };
            };
        };
    };
}
