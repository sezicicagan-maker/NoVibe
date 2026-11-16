#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

%hook UIImpactFeedbackGenerator
- (void)impactOccurred {}
- (void)impactOccurredWithIntensity:(CGFloat)intensity {}
%end

%hook UINotificationFeedbackGenerator
- (void)notificationOccurred:(UINotificationFeedbackType)notificationType {}
%end

%hook UISelectionFeedbackGenerator
- (void)selectionChanged {}
%end

%hookf(void, AudioServicesPlaySystemSound, SystemSoundID inSystemSoundID) {
    if (inSystemSoundID == kSystemSoundID_Vibrate || inSystemSoundID == 1519 || inSystemSoundID == 1520 || inSystemSoundID == 1521) {
        return;
    }
    %orig;
}

%hookf(void, AudioServicesPlaySystemSoundWithCompletion, SystemSoundID inSystemSoundID, void (^inCompletionBlock)(void)) {
    if (inSystemSoundID == kSystemSoundID_Vibrate || inSystemSoundID == 1519 || inSystemSoundID == 1520 || inSystemSoundID == 1521) {
        if (inCompletionBlock) inCompletionBlock();
        return;
    }
    %orig;
}
