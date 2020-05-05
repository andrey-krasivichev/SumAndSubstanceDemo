//
//  SNSLiveness3D.h
//  IdensicMobileSDK_Liveness3D
//
//  Copyright © 2019 Sum & Substance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNSLiveness3DThemeProtocol.h"
#import "SNSLiveness3DResult.h"

typedef NS_ENUM(NSInteger, SNSLiveness3DMode) {
    SNSLiveness3DMode_FaceLiveness,
    SNSLiveness3DMode_FaceAuth,
};

typedef NS_ENUM(NSInteger, SNSLiveness3DStatus) {
    SNSLiveness3DStatus_Cancelled,
    SNSLiveness3DStatus_InitializationFailed,
    SNSLiveness3DStatus_CameraPermissionDenied,
    SNSLiveness3DStatus_TokenIsInvalid,
    SNSLiveness3DStatus_FaceMismatched,
    SNSLiveness3DStatus_VerificationPassedSuccessfully,
};

@class SNSLiveness3D;

NS_ASSUME_NONNULL_BEGIN

typedef void(^SNSLiveness3DResultHandler)(SNSLiveness3DResult *result, void(^completionHandler)(BOOL stopProcessing));
typedef void(^SNSLiveness3DTokenExpirationHandler)(void(^completionHandler)(NSString * __nullable newToken));
typedef void(^SNSLiveness3DCompletionHandler)(UIViewController *controller, SNSLiveness3DStatus status, SNSLiveness3DResult * __nullable result);
typedef NSString * __nullable(^SNSLiveness3DTextHandler)(NSString *key, NSString *locale);
typedef UIImage * __nullable(^SNSLiveness3DImageHandler)(NSString *key);

#pragma mark -

@interface SNSLiveness3D : NSObject

+ (NSString *)descriptionForStatus:(SNSLiveness3DStatus)status;

@property (nonatomic, copy, nullable) NSString *applicantId;

/**
 * Optional asynchronous handler to be called right after a new result is got from the server.
 * Must call `completionHandler` passed with a boolean parameter.
 * Pass `YES` to stop further processing.
 */
@property (nonatomic, copy, nullable) SNSLiveness3DResultHandler resultHandler;
@property (nonatomic, copy, nullable) SNSLiveness3DTextHandler textHandler;
@property (nonatomic, copy, nullable) SNSLiveness3DImageHandler imageHandler;
@property (nonatomic) id<SNSLiveness3DThemeProtocol> theme;

@property (nonatomic) BOOL shouldCompleteOnFaceMismatch;

- (instancetype)initWithMode:(SNSLiveness3DMode)mode
                     baseUrl:(NSString *)baseUrl
                 applicantId:(NSString *)applicantId
                       token:(NSString *)token
                      locale:(NSString *)locale
      tokenExpirationHandler:(SNSLiveness3DTokenExpirationHandler)tokenExpirationHandler
           completionHandler:(SNSLiveness3DCompletionHandler)completionHandler;

- (UIViewController *)getController;

@end

NS_ASSUME_NONNULL_END
