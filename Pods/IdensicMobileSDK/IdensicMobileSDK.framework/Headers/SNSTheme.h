//
//  SNSTheme.h
//  IdensicMobileSDK
//

#import <UIKit/UIKit.h>
#import "SNSLiveness3DTheme.h"

typedef NS_ENUM(NSInteger, SNSThemeDimmingEffect) {
    SNSThemeDimmingEffect_None,
    SNSThemeDimmingEffect_Blur,
    SNSThemeDimmingEffect_FadeIn,
};

@interface SNSTheme : NSObject

+ (nonnull instancetype)darkTheme;

#pragma mark - General

@property (nonatomic) UIStatusBarStyle sns_preferredStatusBarStyle;

@property (nonatomic, nullable) UIColor *sns_navbarBarTintColor;
@property (nonatomic, nullable) UIColor *sns_navbarTintColor;

@property (nonatomic, nullable) UIImage *sns_closeButtonImage;

@property (nonatomic, nullable) UIColor *sns_alertTintColor;

@property (nonatomic, nullable) UIFont *sns_poweredByFont;
@property (nonatomic, nullable) UIColor *sns_poweredByColor;

#pragma mark - Buttons

@property (nonatomic, nullable) UIFont *sns_actionButtonFont;
@property (nonatomic) CGFloat sns_actionButtonCornerRadius;
@property (nonatomic) CGFloat sns_actionButtonHeight;

@property (nonatomic, nullable) UIColor *sns_actionButtonTitleColor;
@property (nonatomic, nullable) UIColor *sns_actionButtonBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_actionButtonHighlightedTitleColor;
@property (nonatomic, nullable) UIColor *sns_actionButtonHighlightedBackgroundColor;

@property (nonatomic, nullable) UIColor *sns_alternativeButtonTitleColor;
@property (nonatomic, nullable) UIColor *sns_alternativeButtonBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_alternativeButtonHighlightedTitleColor;
@property (nonatomic, nullable) UIColor *sns_alternativeButtonHighlightedBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_alternativeButtonBorderColor;

#pragma mark - Oops Screen

@property (nonatomic, nullable) UIFont *sns_OopsScreenTitleFont;
@property (nonatomic, nullable) UIFont *sns_OopsScreenTextFont;
@property (nonatomic, nullable) UIColor *sns_OopsScreenTitleColor;
@property (nonatomic, nullable) UIColor *sns_OopsScreenTextColor;

@property (nonatomic, nullable) UIImage *sns_OopsScreenNetworkFailImage;
@property (nonatomic, nullable) UIImage *sns_OopsScreenFatalFailImage;

#pragma mark - Status Screen

@property (nonatomic, nullable) UIColor *sns_StatusScreenBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_StatusScreenSpinnerColor;

@property (nonatomic, nullable) UIFont *sns_StatusHeaderTitleFont;
@property (nonatomic, nullable) UIFont *sns_StatusHeaderSubtitleFont;
@property (nonatomic, nullable) UIColor *sns_StatusHeaderTitleColor;
@property (nonatomic, nullable) UIColor *sns_StatusHeaderSubtitleColor;

@property (nonatomic) SNSThemeDimmingEffect sns_StatusFooterDimmingEffect;
@property (nonatomic) UIBlurEffectStyle sns_StatusFooterBlurEffectStyle;
@property (nonatomic, nullable) UIFont *sns_StatusFooterTextFont;
@property (nonatomic, nullable) UIColor *sns_StatusFooterBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_StatusFooterTextColor;
@property (nonatomic, nullable) UIColor *sns_StatusFooterLinkColor;

@property (nonatomic, nullable) UIImage *sns_StatusScreenFinalRejectImage;

#pragma mark - idDocs

@property (nonatomic, nullable) UIFont *sns_idDocStatusPromptTextFont;
@property (nonatomic, nullable) UIColor *sns_idDocStatusPromptTextColor;
@property (nonatomic, nullable) UIColor *sns_idDocStatusPromptBackgroundColor;

@property (nonatomic, nullable) UIFont *sns_idDocStatusSubmittedTitleFont;
@property (nonatomic, nullable) UIFont *sns_idDocStatusSubmittedSubtitleFont;
@property (nonatomic, nullable) UIColor *sns_idDocStatusSubmittedTextColor;
@property (nonatomic, nullable) UIColor *sns_idDocStatusSubmittedBackgroundColor;
@property (nonatomic, nullable) UIImage *sns_idDocStatusSubmittedImage;

@property (nonatomic, nullable) UIFont *sns_idDocStatusNotSubmittedTitleFont;
@property (nonatomic, nullable) UIFont *sns_idDocStatusNotSubmittedSubtitleFont;
@property (nonatomic, nullable) UIColor *sns_idDocStatusNotSubmittedTextColor;
@property (nonatomic, nullable) UIColor *sns_idDocStatusNotSubmittedBackgroundColor;
@property (nonatomic, nullable) UIImage *sns_idDocStatusNotSubmittedImage;

@property (nonatomic, nullable) UIFont *sns_idDocStatusReviewingTitleFont;
@property (nonatomic, nullable) UIFont *sns_idDocStatusReviewingSubtitleFont;
@property (nonatomic, nullable) UIColor *sns_idDocStatusReviewingTextColor;
@property (nonatomic, nullable) UIColor *sns_idDocStatusReviewingBackgroundColor;
@property (nonatomic, nullable) UIImage *sns_idDocStatusReviewingImage;

@property (nonatomic, nullable) UIFont *sns_idDocStatusDeclinedTitleFont;
@property (nonatomic, nullable) UIFont *sns_idDocStatusDeclinedSubtitleFont;
@property (nonatomic, nullable) UIColor *sns_idDocStatusDeclinedTextColor;
@property (nonatomic, nullable) UIColor *sns_idDocStatusDeclinedBackgroundColor;
@property (nonatomic, nullable) UIImage *sns_idDocStatusDeclinedImage;

@property (nonatomic, nullable) UIFont *sns_idDocStatusApprovedTitleFont;
@property (nonatomic, nullable) UIFont *sns_idDocStatusApprovedSubtitleFont;
@property (nonatomic, nullable) UIColor *sns_idDocStatusApprovedTextColor;
@property (nonatomic, nullable) UIColor *sns_idDocStatusApprovedBackgroundColor;
@property (nonatomic, nullable) UIImage *sns_idDocStatusApprovedImage;

@property (nonatomic) CGFloat sns_idDocBackgroundCornerRadius;
@property (nonatomic) CGFloat sns_idDocDisclosureDarkFactor;
@property (nonatomic) CGFloat sns_idDocHighlightDarkFactor;

@property (nonatomic, nullable) UIImage *sns_idDocDisclosureImage;

#pragma mark - Camera Screen

@property (nonatomic, nullable) UIColor *sns_CameraScreenBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenSpinnerColor;

@property (nonatomic, nullable) UIColor *sns_CameraScreenCloseButtonTintColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenTorchButtonTintColor;

@property (nonatomic, nullable) UIColor *sns_CameraScreenCaptureButtonColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenCaptureButtonHighlightedColor;

@property (nonatomic, nullable) UIFont *sns_CameraScreenScanResultStatusTextFont;
@property (nonatomic, nullable) UIColor *sns_CameraScreenScanResultStatusTextColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenScanResultStatusBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenScanActivityIndicatorColor;

@property (nonatomic, nullable) UIFont *sns_CameraScreenInfoTitleFont;
@property (nonatomic, nullable) UIFont *sns_CameraScreenInfoTextFont;
@property (nonatomic, nullable) UIColor *sns_CameraScreenInfoBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenInfoTitleColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenInfoTextColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenInfoHandlerOutsideColor;
@property (nonatomic, nullable) UIColor *sns_CameraScreenInfoHandlerInsideColor;

@property (nonatomic, nullable) UIImage *sns_CameraScreenTorchOnImage;
@property (nonatomic, nullable) UIImage *sns_CameraScreenTorchOffImage;

#pragma mark - Video Screen

@property (nonatomic, nullable) UIColor *sns_VideoScreenBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_VideoScreenDimColor;
@property (nonatomic, nullable) UIColor *sns_VideoScreenSpinnerColor;

@property (nonatomic, nullable) UIFont *sns_VideoScreenCountDownFont;
@property (nonatomic, nullable) UIColor *sns_VideoScreenCountDownColor;

@property (nonatomic, nullable) UIColor *sns_VideoScreenCloseButtonTintColor;

@property (nonatomic, nullable) UIColor *sns_VideoScreenRecordButtonBorderColor;
@property (nonatomic, nullable) UIColor *sns_VideoScreenRecordingColor;

@property (nonatomic, nullable) UIColor *sns_VideoScreenViewPortBorderColor;
@property (nonatomic, nullable) UIColor *sns_VideoScreenViewPortBorderActiveColor;
@property (nonatomic) CGFloat sns_VideoScreenViewPortBorderWidth;

@property (nonatomic, nullable) UIFont *sns_VideoScreenReadAloudTextFont;
@property (nonatomic, nullable) UIColor *sns_VideoScreenReadAloudTextColor;
@property (nonatomic, nullable) UIColor *sns_VideoScreenReadAloudBackgroundColor;

@property (nonatomic, nullable) UIFont *sns_VideoScreenFooterHeaderFont;
@property (nonatomic, nullable) UIFont *sns_VideoScreenFooterTextFont;
@property (nonatomic, nullable) UIColor *sns_VideoScreenFooterHeaderColor;
@property (nonatomic, nullable) UIColor *sns_VideoScreenFooterTextColor;

#pragma mark - Preview Screen

@property (nonatomic, nullable) UIFont *sns_PreviewScreenTitleFont;
@property (nonatomic, nullable) UIFont *sns_PreviewScreenSubtitleFont;
@property (nonatomic, nullable) UIColor *sns_PreviewScreenBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_PreviewScreenTitleColor;
@property (nonatomic, nullable) UIColor *sns_PreviewScreenSubtitleColor;
@property (nonatomic, nullable) UIColor *sns_PreviewScreenSpinnerColor;

@property (nonatomic, nullable) UIImage *sns_PreviewScreenVideoPlayImage;

#pragma mark - Support Screen

@property (nonatomic, nullable) UIFont *sns_SupportScreenItemButtonFont;
@property (nonatomic, nullable) UIFont *sns_SupportScreenItemDescriptionFont;
@property (nonatomic, nullable) UIColor *sns_SupportScreenBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_SupportScreenItemButtonColor;
@property (nonatomic, nullable) UIColor *sns_SupportScreenItemDescriptionColor;

@property (nonatomic, nullable) UIColor *sns_SupportScreenEmailImageTintColor;
@property (nonatomic, nullable) UIImage *sns_SupportScreenEmailImage;

#pragma mark - ToS Screen

@property (nonatomic, nullable) UIColor *sns_TosScreenBackgroundColor;
@property (nonatomic, nullable) UIColor *sns_TosScreenSpinnerColor;

#pragma mark - Liveness3D

@property (nonatomic, nullable) SNSLiveness3DTheme *liveness3DTheme;

@end
