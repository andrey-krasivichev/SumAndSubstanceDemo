//
//  SNSLiveness3DTheme.h
//  IdensicMobileSDK
//

#import <Foundation/Foundation.h>
#import "SNSLiveness3DThemeProtocol.h"

@interface SNSLiveness3DTheme : NSObject <SNSLiveness3DThemeProtocol>

+ (nonnull instancetype)darkTheme;

@property (nonatomic, nullable) UIColor *sns_LivenessScreenBackgroundColor;

@property (nonatomic, nullable) UIFont *sns_LivenessScreenTitleFont;
@property (nonatomic, nullable) UIFont *sns_LivenessScreenStateFont;
@property (nonatomic, nullable) UIFont *sns_LivenessScreenStatusFont;
@property (nonatomic, nullable) UIFont *sns_LivenessScreenActionButtonFont;
@property (nonatomic, nullable) UIFont *sns_LivenessScreenCancelButtonFont;

@property (nonatomic, nullable) UIColor *sns_LivenessScreenTitleColor;
@property (nonatomic, nullable) UIColor *sns_LivenessScreenStateColor;
@property (nonatomic, nullable) UIColor *sns_LivenessScreenStatusColor;
@property (nonatomic, nullable) UIColor *sns_LivenessScreenActionButtonColor;
@property (nonatomic, nullable) UIColor *sns_LivenessScreenCancelButtonColor;

@property (nonatomic, nullable) UIImage *sns_LivenessScreenWarningImage;

#pragma mark - Zoom

@property (nonatomic, nullable) UIFont *sns_ZoomButtonFont;
@property (nonatomic, nullable) UIFont *sns_ZoomHeaderFont;
@property (nonatomic, nullable) UIFont *sns_ZoomSubtextFont;
@property (nonatomic, nullable) UIFont *sns_ZoomFeebdbackTextFont;
@property (nonatomic, nullable) UIFont *sns_ZoomResultScreenMessageFont;

/// 2 colors for gradient locations 0, 1
@property (nonatomic, nullable) NSArray<UIColor *> *sns_ZoomMainGradientColors;
@property (nonatomic, nullable) UIColor *sns_ZoomMainForegroundColor;
@property (nonatomic, nullable) UIColor *sns_ZoomFrameBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_ZoomFrameBorderColor;
@property (nonatomic) CGFloat sns_ZoomFrameBorderWidth;
@property (nonatomic) CGFloat sns_ZoomFrameCornerRadius;

@property (nonatomic, nullable) UIColor *sns_ZoomButtonColor;
@property (nonatomic, nullable) UIColor *sns_ZoomButtonHighlightColor;
@property (nonatomic, nullable) UIColor *sns_ZoomButtonDisabledColor;
@property (nonatomic, nullable) UIColor *sns_ZoomButtonBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_ZoomButtonBackgroundHighlightColor;
@property (nonatomic, nullable) UIColor *sns_ZoomButtonBackgroundDisabledColor;
@property (nonatomic, nullable) UIColor *sns_ZoomButtonBorderColor;
@property (nonatomic) CGFloat sns_ZoomButtonCornerRadius;

@property (nonatomic) SNSZoomCancelButtonMode sns_ZoomCancelButtonMode;
@property (nonatomic, nullable) UIImage *sns_ZoomCancelButtonImage;
@property (nonatomic, nullable) UIColor *sns_ZoomCancelButtonTextColor;

@property (nonatomic, nullable) UIColor *sns_ZoomReadyScreenOvalFillColor;

@property (nonatomic, nullable) UIColor *sns_ZoomProgressColor;
@property (nonatomic, nullable) UIColor *sns_ZoomOvalBorderColor;
/// Number of colors must match to the number of `sns_ZoomFeedbackGradientLocations`
@property (nonatomic, nullable) NSArray<UIColor *> *sns_ZoomFeedbackGradientColors;
/// Number of locations must match to the number of `sns_ZoomFeedbackGradientColors`
@property (nonatomic, nullable) NSArray<NSNumber *> *sns_ZoomFeedbackGradientLocations;
@property (nonatomic, nullable) UIColor *sns_ZoomFeedbackTextColor;

@property (nonatomic, nullable) UIColor *sns_ZoomResultActivityIndicatorColor;
@property (nonatomic, nullable) UIColor *sns_ZoomResultAnimationBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_ZoomResultAnimationForegroundColor;

@property (nonatomic, nullable) UIImage *sns_ZoomIdealZoomImage;
@property (nonatomic, nullable) UIImage *sns_ZoomCameraPermissionsScreenImage;

/// Own customization, could be used instead of the above sns_Zoom* options
@property (nonatomic, nullable) ZoomCustomization *sns_ZoomCustomization;
/// Own customization, could be used instead of the above sns_Zoom* options in Low Light Mode
@property (nonatomic, nullable) ZoomCustomization *sns_ZoomLowLightCustomization;

@end
