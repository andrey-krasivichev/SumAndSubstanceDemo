//
//  SNSMobileSDK.h
//  IdensicMobileSDK
//

#import <UIKit/UIKit.h>

@class SNSMobileSDK;
@class SNSSupportItem;
@class SNSTheme;

/**
 * SDK Status
 */
typedef NS_CLOSED_ENUM(NSInteger, SNSMobileSDKStatus) {
    
    /// SDK is not initialized yet
    SNSMobileSDKStatus_NotInitialized,
    
    /// SDK is initialized and ready to be presented
    SNSMobileSDKStatus_Ready,
    
    /// SDK fails to operate for some reasons (see `failReason` and `verboseStatus` for details)
    SNSMobileSDKStatus_Failed,
    
    /// No verification steps are passed yet
    SNSMobileSDKStatus_Initial,
    
    /// Some but not all verification steps are passed over
    SNSMobileSDKStatus_Incomplete,
    
    /// Verification is in pending state
    SNSMobileSDKStatus_Pending,
    
    /// Applicant has been declined temporarily
    SNSMobileSDKStatus_TemporarilyDeclined,
    
    /// Applicant has been finally rejected
    SNSMobileSDKStatus_FinallyRejected,
    
    /// Applicant has been approved
    SNSMobileSDKStatus_Approved,

} NS_SWIFT_NAME(SNSMobileSDK.Status);

/**
 * Fail reasons (see `verboseStatus` for details of the fail)
 */
typedef NS_ENUM(NSInteger, SNSFailReason) {
    
    /// Unknown or no fail
    SNSFailReason_Unknown,

    /// An attempt to setup with invalid parameters
    SNSFailReason_InvalidParameters,
    
    /// Unauthorized access detected (most likely `accessToken` is invalid or expired and had failed to be refreshed)
    SNSFailReason_Unauthorized,

    /// Initial loading from backend is failed
    SNSFailReason_InitialLoadingFailed,
    
    /// No applicant found for the given `applicantId`
    SNSFailReason_ApplicantNotFound,
    
    /// Applicant is found, but is misconfigured (most likely lacks of idDocs)
    SNSFailReason_ApplicantMisconfigured,
};

/**
 * Log levels
 */
typedef NS_ENUM(NSInteger, SNSLogLevel) {
    
    /// Logs nothing
    SNSLogLevel_Off = 0,
    
    /// Logs errors (default)
    SNSLogLevel_Error = 1,

    /// Logs warnings
    SNSLogLevel_Warning = 2,

    /// Logs debug info
    SNSLogLevel_Info = 3,

    /// Logs even more debug info
    SNSLogLevel_Debug = 4,
    
    /// Logs as much as possible
    SNSLogLevel_Trace = 5
};

#pragma mark -

typedef void(^SNSTokenExpirationHandler)(void(^_Nonnull onComplete)(NSString * _Nullable newAccessToken));
typedef void(^SNSVerificationHandler)(BOOL isApproved);
typedef void(^SNSLogHandler)(SNSLogLevel level, NSString * _Nonnull message);
typedef void(^SNSDimissHandler)(SNSMobileSDK * _Nonnull sdk, UINavigationController * _Nonnull mainVC);

typedef void(^SNSAddSupportItemBlock)(SNSSupportItem * _Nonnull item);

typedef void(^SNSOnStatusDidChangeCallback)(SNSMobileSDK * _Nonnull sdk, SNSMobileSDKStatus prevStatus);
typedef void(^SNSOnDidDismissCallback)(SNSMobileSDK * _Nonnull sdk);

#pragma mark -

@interface SNSMobileSDK : NSObject

/**
 * Prepares SDK for the launch
 *
 * @param baseUrl Base url to the backend. Please, use full qualified url with `https://` prefix
 * @param applicantId An identifier of the applicant to be verified (must be already created)
 * @param accessToken An access token
 * @param locale Use locale in a form of `en_US`
 * @param supportEmail A convinient way to configure Support screen with email only. See `supportItems` for more advanced ways.
 *
 * @discussion
 * Upon setup check `isReady` property. It should be `true` on success, otherwise see `failReason` and `verboseStatus` for the fail details.
 */
+ (nonnull instancetype)setupWithBaseUrl:(nonnull NSString *)baseUrl
                             applicantId:(nonnull NSString *)applicantId
                             accessToken:(nonnull NSString *)accessToken
                                  locale:(nullable NSString *)locale
                            supportEmail:(nullable NSString *)supportEmail

NS_SWIFT_NAME(init(baseUrl:applicantId:accessToken:locale:supportEmail:));

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 * Sets token expiration handler
 *
 * @param handler A closure that takes another closure `onComplete` as the only parameter.
 *
 * @discussion
 * Token expiration handler fired when `accessToken` is expired.
 * MUST call `onComplete` with new `accessToken` as a parameter.
 */
- (void)tokenExpirationHandler:(nullable SNSTokenExpirationHandler)handler;

/**
 * Sets verification handler
 *
 * @param handler A closure that takes boolean parameter `isApproved`.
 *
 * @discussion
 * Verification handler would be called when verification is done with a final decision (the applicant is approved or finally rejected).
 *
 * See also `onStatusDidChange` to get notified of other stages of the verification process.
 */
- (void)verificationHandler:(nullable SNSVerificationHandler)handler;

#pragma mark - UI

/**
 * Main view controller of the SDK's user interface
 *
 * @discussion
 * Upon success setup get and present `mainVC` from your view controller
 */
@property (nonatomic, readonly, nullable) UINavigationController *mainVC;

/**
 * Sets an optional handler to dimiss the main view controller
 *
 * @param handler A closure that takes two parameters - the SDK instance and the `mainVC` controller.
 * 
 * @discussion
 * The handler would be called when user wants to leave the main screen. It's up to you to dismiss the `mainVC` controller.
 */
- (void)dismissHandler:(nullable SNSDimissHandler)handler;

#pragma mark - Callbacks

/**
 * Sets an optional callback fired when `mainVC` is dismissed.
 *
 * @param callback A closure that takes the SDK instance.
 */
- (void)onDidDismiss:(nullable SNSOnDidDismissCallback)callback;

/**
 * Sets an optional callback fired when `status` is changed.
 *
 * @param callback A callback that takes two parameters - the SDK instance and the previous value of the `status`.
 *
 * @discussion
 * Use the callback to get notified of the stages of the verification process.
 */
- (void)onStatusDidChange:(nullable SNSOnStatusDidChangeCallback)callback;

#pragma mark - Status

/**
 * SDK implies to be `Ready` when it's initialized successfully
 */
@property (nonatomic, readonly) BOOL isReady;

/**
 * Current SDK status
 */
@property (nonatomic, readonly) SNSMobileSDKStatus status;

/**
 * Describes the reason of the last fail if any. Makes sence when `status` is `Failed`.
 */
@property (nonatomic, readonly) SNSFailReason failReason;

/**
 * Verbose SDK status
 *
 * @discussion
 * Returns SDK status as a text. Could contain detailed info for `Failed` case.
 */
@property (nonatomic, readonly, nonnull) NSString *verboseStatus;

/**
 * Provides default description for the given SDK status
 */
- (nonnull NSString *)descriptionForStatus:(SNSMobileSDKStatus)status;

/**
 * Provides default description for the given fail reason
 */
- (nonnull NSString *)descriptionForFailReason:(SNSFailReason)failReason;

#pragma mark - Customization

/**
 * Customization Theme
 * 
 * @discussion
 * One can pass own theme object of `SNSTheme` class or adjust the default one using writtable properties
 */
@property (nonatomic, nonnull) SNSTheme *theme;

/**
 * Name of the .strings file to get texts from.
 *
 * @discussion
 * By default SDK looks for `IdensicMobileSDK.strings` file in the main bundle.
 * If you'd like to keep localizations in another .strings file, assign its name here (just the name, without .strings extension)
 */
@property (nonatomic, nonnull) NSString *localizationTableName;

/**
 * Array of items to be displayed at Support screen.
 *
 * @discussion
 * Initially if non-empty `supportEmail` parameter passed during setup, then Email item would be auto created.
 *
 * Feel free to reconfigure support items as required. See `SNSSupportItem` for details.
 */
@property (nonatomic, nullable) NSArray<SNSSupportItem *> *supportItems;

/**
 * A convenience method to add a support item
 *
 * @param configure New support item is created and passed into the block to be configured as required
 */
- (void)addSupportItemWithBlock:(nonnull NS_NOESCAPE SNSAddSupportItemBlock)configure;

#pragma mark - Logging

/**
 * Logging level (`Off` by default)
 */
@property (nonatomic) SNSLogLevel logLevel;

/**
 * Sets an optional log handler
 *
 * @param handler A close that takes `logLevel` and `message` to be logged.
 *
 * @discussion
 * By default SDK uses `NSLog` for the logging purposes. If for some reasons it does not work for you, feel free to use `logHandler` to intercept log messages and direct them as required.
 */
- (void)logHandler:(nullable SNSLogHandler)handler;

#pragma mark - Settings

/**
 * Custom settings
 *
 * @discussion Reserved for the future needs.
 */
@property (nonatomic, nullable) NSDictionary *settings;

#pragma mark - Aliases

/// Alias for `tokenExpirationHandler:` method
- (void)setTokenExpirationHandler:(nullable SNSTokenExpirationHandler)handler;
/// Alias for `verificationHandler:` method
- (void)setVerificationHandler:(nullable SNSVerificationHandler)handler;
/// Alias for `dismissHandler:` method
- (void)setDismissHandler:(nullable SNSDimissHandler)handler;
/// Alias for `onDidDismiss:`
- (void)setOnDidDismiss:(nullable SNSOnDidDismissCallback)callback;
/// Alias for `onStatusDidChange:` method
- (void)setOnStatusDidChange:(nullable SNSOnStatusDidChangeCallback)callback;
/// Alias for `logHandler:` method
- (void)setLogHandler:(nullable SNSLogHandler)handler;

@end
