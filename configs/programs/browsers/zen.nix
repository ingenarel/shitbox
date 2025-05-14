{inputs, ...}: {
    home-manager.users.ingenarel = {
        imports = [
            inputs.zen-browser.homeModules.twilight-official
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
                NoDefaultBookmarks = true;
                OfferToSaveLogins = false;
            };
            profiles.default = {
                bookmarks = {
                    force = true;
                    settings = [
                        {
                            name = "archwiki";
                            url = "wiki.archlinux.org";
                        }
                    ];
                };
            };
        };
    };
}
