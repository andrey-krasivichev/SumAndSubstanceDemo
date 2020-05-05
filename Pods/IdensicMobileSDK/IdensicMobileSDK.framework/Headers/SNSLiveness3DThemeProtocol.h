//
//  SNSLiveness3DThemeProtocol.h
//  IdensicMobileSDK_Liveness3D
//

#ifndef SNSLiveness3DThemeProtocol_h
#define SNSLiveness3DThemeProtocol_h

@class ZoomCustomization;

typedef NS_ENUM(NSInteger, SNSZoomCancelButtonMode) {
    /// Renders `sns_ZoomCancelButtonImage` at the top
    SNSZoomCancelButtonMode_Image,
    /// Tries keep Cancel button at the bottom if the screen's height is tall enough
    SNSZoomCancelButtonMode_TextAtBottomIfPossible,
};

@protocol SNSLiveness3DThemeProtocol <NSObject>

@optional

@property (nonatomic) UIColor *sns_LivenessScreenBackgroundColor;

@property (nonatomic) UIFont *sns_LivenessScreenTitleFont;
@property (nonatomic) UIFont *sns_LivenessScreenStateFont;
@property (nonatomic) UIFont *sns_LivenessScreenStatusFont;
@property (nonatomic) UIFont *sns_LivenessScreenActionButtonFont;
@property (nonatomic) UIFont *sns_LivenessScreenCancelButtonFont;

@property (nonatomic) UIColor *sns_LivenessScreenTitleColor;
@property (nonatomic) UIColor *sns_LivenessScreenStateColor;
@property (nonatomic) UIColor *sns_LivenessScreenStatusColor;
@property (nonatomic) UIColor *sns_LivenessScreenActionButtonColor;
@property (nonatomic) UIColor *sns_LivenessScreenCancelButtonColor;

@property (nonatomic) UIImage *sns_LivenessScreenWarningImage;

#pragma mark - Zoom

@property (nonatomic) UIFont *sns_ZoomButtonFont;
@property (nonatomic) UIFont *sns_ZoomHeaderFont;
@property (nonatomic) UIFont *sns_ZoomSubtextFont;
@property (nonatomic) UIFont *sns_ZoomFeebdbackTextFont;
@property (nonatomic) UIFont *sns_ZoomResultScreenMessageFont;

/// 2 colors for gradient locations 0, 1
@property (nonatomic) NSArray<UIColor *> *sns_ZoomMainGradientColors;
@property (nonatomic) UIColor *sns_ZoomMainForegroundColor;
@property (nonatomic) UIColor *sns_ZoomFrameBackgroundColor;
@property (nonatomic) UIColor *sns_ZoomFrameBorderColor;
@property (nonatomic) CGFloat sns_ZoomFrameBorderWidth;
@property (nonatomic) CGFloat sns_ZoomFrameCornerRadius;

@property (nonatomic) UIColor *sns_ZoomButtonColor;
@property (nonatomic) UIColor *sns_ZoomButtonHighlightColor;
@property (nonatomic) UIColor *sns_ZoomButtonDisabledColor;
@property (nonatomic) UIColor *sns_ZoomButtonBackgroundColor;
@property (nonatomic) UIColor *sns_ZoomButtonBackgroundHighlightColor;
@property (nonatomic) UIColor *sns_ZoomButtonBackgroundDisabledColor;
@property (nonatomic) UIColor *sns_ZoomButtonBorderColor;
@property (nonatomic) CGFloat sns_ZoomButtonCornerRadius;

@property (nonatomic) SNSZoomCancelButtonMode sns_ZoomCancelButtonMode;
@property (nonatomic) UIImage *sns_ZoomCancelButtonImage;
@property (nonatomic) UIColor *sns_ZoomCancelButtonTextColor;

@property (nonatomic) UIColor *sns_ZoomReadyScreenOvalFillColor;

@property (nonatomic) UIColor *sns_ZoomProgressColor;
@property (nonatomic) UIColor *sns_ZoomOvalBorderColor;
/// Number of colors must match to the number of `sns_ZoomFeedbackGradientLocations`
@property (nonatomic) NSArray<UIColor *> *sns_ZoomFeedbackGradientColors;
/// Number of locations must match to the number of `sns_ZoomFeedbackGradientColors`
@property (nonatomic) NSArray<NSNumber *> *sns_ZoomFeedbackGradientLocations;
@property (nonatomic) UIColor *sns_ZoomFeedbackTextColor;

@property (nonatomic) UIColor *sns_ZoomResultActivityIndicatorColor;
@property (nonatomic) UIColor *sns_ZoomResultAnimationBackgroundColor;
@property (nonatomic) UIColor *sns_ZoomResultAnimationForegroundColor;

@property (nonatomic) UIImage *sns_ZoomIdealZoomImage;
@property (nonatomic) UIImage *sns_ZoomCameraPermissionsScreenImage;

/// Own customization, could be used instead of the above sns_Zoom* options
@property (nonatomic) ZoomCustomization *sns_ZoomCustomization;
/// Own customization, could be used instead of the above sns_Zoom* options in Low Light Mode
@property (nonatomic) ZoomCustomization *sns_ZoomLowLightCustomization;

@end

#endif /* SNSLiveness3DThemeProtocol_h */
