{inputs, ...}: {
    home-manager.users.ingenarel = {
        imports = [
            inputs.nixcord.homeModules.nixcord
        ];
        programs.nixcord = {
            enable = true;
            discord = {
                enable = false;
                vencord.enable = false;
                openASAR.enable = false;
            };
            vesktop.enable = true;
            quickCss = builtins.readFile ./theme.css;
            config = {
                useQuickCss = true;
                frameless = true;
                transparent = true;
                disableMinSize = true;
                plugins = {
                    anonymiseFileNames.enable = true;
                    betterFolders = {
                        enable = true;
                        sidebarAnim = false;
                        closeAllFolders = true;
                        closeAllHomeButton = true;
                        closeOthers = true;
                        forceOpen = true;
                    };
                    callTimer.enable = true;
                    clearURLs.enable = true;
                    crashHandler.enable = true;
                    fakeNitro.enable = true;
                    iLoveSpam.enable = true;
                    imageLink.enable = true;
                    imageZoom.enable = true;
                    memberCount.enable = true;
                    messageLatency.enable = true;
                    messageLinkEmbeds.enable = true;
                    messageLogger.enable = true;
                    moreUserTags.enable = true;
                    noBlockedMessages.enable = true;
                    noTypingAnimation.enable = true;
                    noUnblockToJump.enable = true;
                    relationshipNotifier.enable = true;
                    typingTweaks.enable = true;
                    unindent.enable = true;
                    voiceDownload.enable = true;
                    voiceMessages.enable = true;
                    webScreenShareFixes.enable = true;
                    whoReacted.enable = true;
                };
            };
        };
    };
}
