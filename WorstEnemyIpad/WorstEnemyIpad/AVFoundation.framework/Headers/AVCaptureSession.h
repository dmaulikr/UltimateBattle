/*
    File:  AVCaptureSession.h

	Framework:  AVFoundation

	Copyright 2010 Apple Inc. All rights reserved.
*/

#import <AVFoundation/AVBase.h>
#import <Foundation/Foundation.h>
#import <CoreMedia/CMFormatDescription.h>

/*!
 @constant  AVCaptureSessionRuntimeErrorNotification
 @abstract
	Posted when an unexpected error occurs while an AVCaptureSession instance is running.
 
 @discussion
	The notification object is the AVCaptureSession instance that encountered a runtime error.
    The userInfo dictionary contains an NSError for the key AVCaptureSessionErrorKey.
*/
extern NSString *const AVCaptureSessionRuntimeErrorNotification NS_AVAILABLE(10_7, 4_0);

/*!
 @constant  AVCaptureSessionErrorKey
 @abstract
	The key used to provide an NSError describing the failure condition in an
    AVCaptureSessionRuntimeErrorNotification.
 
 @discussion
	AVCaptureSessionErrorKey may be found in the userInfo dictionary provided with
    an AVCaptureSessionRuntimeErrorNotification.  The NSError associated with the
    notification gives greater detail on the nature of the error, and in some cases
    recovery suggestions. 
*/
extern NSString *const AVCaptureSessionErrorKey NS_AVAILABLE(10_7, 4_0);

/*!
 @constant  AVCaptureSessionDidStartRunningNotification
 @abstract
	Posted when an instance of AVCaptureSession successfully starts running.
 
 @discussion
	Clients may observe the AVCaptureSessionDidStartRunningNotification to know
    when an instance of AVCaptureSession starts running.
*/
extern NSString *const AVCaptureSessionDidStartRunningNotification NS_AVAILABLE(10_7, 4_0);

/*!
 @constant  AVCaptureSessionDidStopRunningNotification
 @abstract
	Posted when an instance of AVCaptureSession stops running.
 
 @discussion
	Clients may observe the AVCaptureSessionDidStopRunningNotification to know
    when an instance of AVCaptureSession stops running.  An AVCaptureSession instance
    may stop running automatically due to external system conditions, such as the
    device going to sleep, or being locked by a user.
*/
extern NSString *const AVCaptureSessionDidStopRunningNotification NS_AVAILABLE(10_7, 4_0);

#if TARGET_OS_IPHONE

/*!
 @constant  AVCaptureSessionWasInterruptedNotification
 @abstract
	Posted when an instance of AVCaptureSession becomes interrupted.
 
 @discussion
	Clients may observe the AVCaptureSessionWasInterruptedNotification to know
    when an instance of AVCaptureSession has been interrupted, for example, by
    an incoming phone call, or alarm, or another application taking control of 
    needed hardware resources.  When appropriate, the AVCaptureSession instance
    will stop running automatically in response to an interruption.
*/
extern NSString *const AVCaptureSessionWasInterruptedNotification NS_AVAILABLE_IPHONE(4_0);

/*!
 @constant  AVCaptureSessionInterruptionEndedNotification
 @abstract
	Posted when an instance of AVCaptureSession ceases to be interrupted.
 
 @discussion
	Clients may observe the AVCaptureSessionInterruptionEndedNotification to know
    when an instance of AVCaptureSession ceases to be interrupted, for example, when
    a  phone call ends, and hardware resources needed to run the session are again
    available.  When appropriate, the AVCaptureSession instance that was previously
    stopped in response to an interruption will automatically restart once the
    interruption ends.
*/
extern NSString *const AVCaptureSessionInterruptionEndedNotification NS_AVAILABLE_IPHONE(4_0);

#endif // TARGET_OS_IPHONE

/*!
 @enum  AVCaptureVideoOrientation
 @abstract
	Constants indicating video orientation, for use with AVCaptureVideoPreviewLayer 
    (see AVCaptureVideoPreviewLayer.h) and AVCaptureConnection (see below).
 
 @constant AVCaptureVideoOrientationPortrait
	Indicates that video should be oriented vertically, home button on the bottom.
 @constant AVCaptureVideoOrientationPortraitUpsideDown
	Indicates that video should be oriented vertically, home button on the top.
 @constant AVCaptureVideoOrientationLandscapeRight
	Indicates that video should be oriented horizontally, home button on the right.
 @constant AVCaptureVideoOrientationLandscapeLeft
	Indicates that video should be oriented horizontally, home button on the left.
*/
enum {
    AVCaptureVideoOrientationPortrait           = 1,
    AVCaptureVideoOrientationPortraitUpsideDown = 2,
    AVCaptureVideoOrientationLandscapeRight     = 3,
    AVCaptureVideoOrientationLandscapeLeft      = 4,
};
typedef NSInteger AVCaptureVideoOrientation;

/*!
 @constant  AVCaptureSessionPresetPhoto
 @abstract
	An AVCaptureSession preset suitable for high resolution photo quality output.
 
 @discussion
	Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetPhoto
    for full resolution photo quality output.
*/
extern NSString *const AVCaptureSessionPresetPhoto NS_AVAILABLE(10_7, 4_0);

/*!
 @constant  AVCaptureSessionPresetHigh
 @abstract
	An AVCaptureSession preset suitable for high quality video and audio output.
 
 @discussion
	Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetHigh
    to achieve high quality video and audio output.  AVCaptureSessionPresetHigh is the
    default sessionPreset value.
*/
extern NSString *const AVCaptureSessionPresetHigh NS_AVAILABLE(10_7, 4_0);

/*!
 @constant  AVCaptureSessionPresetMedium
 @abstract
	An AVCaptureSession preset suitable for medium quality output.
 
 @discussion
	Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetMedium
    to achieve output video and audio bitrates suitable for sharing over WiFi.
*/
extern NSString *const AVCaptureSessionPresetMedium NS_AVAILABLE(10_7, 4_0);

/*!
 @constant  AVCaptureSessionPresetLow
 @abstract
	An AVCaptureSession preset suitable for low quality output.
 
 @discussion
	Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetLow
    to achieve output video and audio bitrates suitable for sharing over 3G.
*/
extern NSString *const AVCaptureSessionPresetLow NS_AVAILABLE(10_7, 4_0);

/*!
 @constant  AVCaptureSessionPreset640x480
 @abstract
	An AVCaptureSession preset suitable for 640x480 video output.
 
 @discussion
	Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPreset640x480
    to achieve VGA quality (640x480) output.
*/
extern NSString *const AVCaptureSessionPreset640x480 NS_AVAILABLE(10_7, 4_0);

/*!
 @constant  AVCaptureSessionPreset1280x720
 @abstract
	An AVCaptureSession preset suitable for 1280x720 video output.
 
 @discussion
	Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPreset1280x720
    to achieve 720p quality (1280x720) output.
*/
extern NSString *const AVCaptureSessionPreset1280x720 NS_AVAILABLE(10_7, 4_0);

@class AVCaptureInput;
@class AVCaptureOutput;
@class AVCaptureSessionInternal;

/*!
 @class AVCaptureSession
 @abstract
	AVCaptureSession is the central hub of the AVFoundation capture classes.
 
 @discussion
	To perform a real-time capture, a client may instantiate AVCaptureSession and add appropriate
    AVCaptureInputs, such as AVCaptureDeviceInput, and outputs, such as AVCaptureMovieFileOutput.
    [AVCaptureSession startRunning] starts the flow of data from the inputs to the outputs, and 
    [AVCaptureSession stopRunning] stops the flow.  A client may set the sessionPreset property to 
    customize the quality level or bitrate of the output.
*/
NS_CLASS_AVAILABLE(10_7, 4_0)
@interface AVCaptureSession : NSObject 
{
@private
	AVCaptureSessionInternal *_internal;
}

/*!
 @method canSetSessionPreset:
 @abstract
	Returns whether the receiver can be configured with the given preset.
 
 @param preset
	An AVCaptureSession preset.
 @result
	YES if the receiver can be set to the given preset, NO otherwise.
 
 @discussion
	An AVCaptureSession instance can be associated with a preset that configures its inputs and outputs to fulfill common
	use cases. This method can be used to determine if the receiver supports the desired preset given its
    current input and output configuration.  The receiver's sessionPreset property may only be 
    set to a certain preset if this method returns YES for that preset.
*/
- (BOOL)canSetSessionPreset:(NSString*)preset;

/*!
 @property sessionPreset
 @abstract
	Indicates the session preset currently in use by the receiver.
 
 @discussion
	The value of this property is an NSString (one of AVCaptureSessionPreset*) indicating 
    the current session preset in use by the receiver.  The sessionPreset property may be set 
    while the receiver is running.
*/
@property(nonatomic, copy) NSString *sessionPreset;

/*!
 @property inputs
 @abstract
	An NSArray of AVCaptureInputs currently added to the receiver.

 @discussion
    The value of this property is an NSArray of AVCaptureInputs currently added to
    the receiver.  Clients can add AVCaptureInputs to a session by calling -addInput:.
*/
@property(nonatomic, readonly) NSArray *inputs;

/*!
 @method canAddInput:
 @abstract
	Returns whether the proposed input can be added to the receiver.
 
 @param input
	An AVCaptureInput instance.
 @result
	YES if the proposed input can be added to the receiver, NO otherwise.
 
 @discussion
	An AVCaptureInput instance can only be added to a session using -addInput: if
    canAddInput: returns YES.
*/
- (BOOL)canAddInput:(AVCaptureInput *)input;

/*!
 @method addInput:
 @abstract
	Adds an AVCaptureInput to the session.
 
 @param input
	An AVCaptureInput instance.
 
 @discussion
	An AVCaptureInput instance can only be added to a session using -addInput: if
    canAddInput: returns YES.  -addInput: may be called while the session is running.
*/
- (void)addInput:(AVCaptureInput *)input;

/*!
 @method removeInput:
 @abstract
	Removes an AVCaptureInput from the session.
 
 @param input
	An AVCaptureInput instance.
 
 @discussion
	-removeInput: may be called while the session is running.
*/
- (void)removeInput:(AVCaptureInput *)input;

/*!
 @property outputs
 @abstract
	An NSArray of AVCaptureOutputs currently added to the receiver.

 @discussion
    The value of this property is an NSArray of AVCaptureOutputs currently added to
    the receiver.  Clients can add AVCaptureOutputs to a session by calling -addOutput:.
*/
@property(nonatomic, readonly) NSArray *outputs;

/*!
 @method canAddOutput:
 @abstract
	Returns whether the proposed output can be added to the receiver.
 
 @param output
	An AVCaptureOutput instance.
 @result
	YES if the proposed output can be added to the receiver, NO otherwise.
 
 @discussion
	An AVCaptureOutput instance can only be added to a session using -addOutput: if
    canAddOutput: returns YES.
*/
- (BOOL)canAddOutput:(AVCaptureOutput *)output;

/*!
 @method addOutput:
 @abstract
	Adds an AVCaptureOutput to the session.
 
 @param output
	An AVCaptureOutput instance.
 
 @discussion
	An AVCaptureOutput instance can only be added to a session using -addOutput: if
    canAddOutput: returns YES.  -addOutput: may be called while the session is running.
*/
- (void)addOutput:(AVCaptureOutput *)output;

/*!
 @method removeOutput:
 @abstract
	Removes an AVCaptureOutput from the session.
 
 @param output
	An AVCaptureOutput instance.
 
 @discussion
	-removeOutput: may be called while the session is running.
*/
- (void)removeOutput:(AVCaptureOutput *)output;

/*!
 @method beginConfiguration
 @abstract
	When paired with commitConfiguration, allows a client to batch multiple configuration
    operations on a running session into atomic updates.

 @discussion
    -beginConfiguration / -commitConfiguration are AVCaptureSession's mechanism
    for batching multiple configuration operations on a running session into atomic
    updates.  After calling [session beginConfiguration], clients may add or remove
    outputs, alter the sessionPreset, or configure individual AVCaptureInput or Output
    properties.  All changes will be pended until the client calls [session commitConfiguration],
    at which time they will be applied together.  -beginConfiguration / -commitConfiguration
    pairs may be nested, and will only be applied when the outermost commit is invoked.
*/
- (void)beginConfiguration;

/*!
 @method commitConfiguration
 @abstract
	When preceded by beginConfiguration, allows a client to batch multiple configuration
    operations on a running session into atomic updates.

 @discussion
    -beginConfiguration / -commitConfiguration are AVCaptureSession's mechanism
    for batching multiple configuration operations on a running session into atomic
    updates.  After calling [session beginConfiguration], clients may add or remove
    outputs, alter the sessionPreset, or configure individual AVCaptureInput or Output
    properties.  All changes will be pended until the client calls [session commitConfiguration],
    at which time they will be applied together.  -beginConfiguration / -commitConfiguration
    pairs may be nested, and will only be applied when the outermost commit is invoked.
*/
- (void)commitConfiguration;

/*!
 @property running
 @abstract
	Indicates whether the session is currently running.
 
 @discussion
	The value of this property is a BOOL indicating whether the receiver is running.
	Clients can key value observe the value of this property to be notified when
	the session automatically starts or stops running.
*/
@property(nonatomic, readonly, getter=isRunning) BOOL running;

/*!
 @property interrupted
 @abstract
	Indicates whether the session is being interrupted.
 
 @discussion
	The value of this property is a BOOL indicating whether the receiver is currently
    being interrupted, such as by a phone call or alarm. Clients can key value observe 
    the value of this property to be notified when the session ceases to be interrupted
    and again has access to needed hardware resources.
*/
@property(nonatomic, readonly, getter=isInterrupted) BOOL interrupted;

/*!
 @method startRunning
 @abstract
	Starts an AVCaptureSession instance running.

 @discussion
	Clients invoke -startRunning to start the flow of data from inputs to outputs connected to 
    the AVCaptureSession instance.  This call blocks until the session object has completely
    started up or failed.  A failure to start running is reported through the AVCaptureSessionRuntimeErrorNotification
    mechanism.
*/
- (void)startRunning;

/*!
 @method stopRunning
 @abstract
	Stops an AVCaptureSession instance that is currently running.

 @discussion
	Clients invoke -stopRunning to stop the flow of data from inputs to outputs connected to 
    the AVCaptureSession instance.  This call blocks until the session object has completely
    stopped.
*/
- (void)stopRunning;

@end



@class AVCaptureAudioChannel;
@class AVCaptureConnectionInternal;

/*!
 @class AVCaptureConnection
 @abstract
	AVCaptureConnection represents a connection between AVCaptureInputs and AVCaptureOutputs added to an
    AVCaptureSession.
 
 @discussion
     AVCaptureInputs have one or more AVCaptureInputPorts.  AVCaptureOutputs can accept
     data from one or more sources (example - an AVCaptureMovieFileOutput accepts both video and audio data).
     Instances of AVCaptureConnection cannot be created directly.  When an input or output is added to 
     a session, the session greedily forms connections between all the compatible AVCaptureInputs' 
     ports and AVCaptureOutputs.  Iterating through an output's connections, a client may enable or 
     disable the flow of data from a given input to a given output.
     
     Connections involving audio expose an array of AVCaptureAudioChannel objects, which can be used for
     monitoring levels.
     
     Connections involving video expose video specific properties, such as videoMirrored and videoOrientation.
*/
NS_CLASS_AVAILABLE(10_7, 4_0)
@interface AVCaptureConnection : NSObject 
{
@private
	AVCaptureConnectionInternal *_internal;
}

/*!
 @property inputPorts
 @abstract
    An array of AVCaptureInputPort instances providing data through this connection.

 @discussion
    An AVCaptureConnection may involve one or more AVCaptureInputPorts producing data
    to the connection's AVCaptureOutput.  This property is read-only.  An AVCaptureConnection's
    inputPorts remain static for the life of the object.  
*/
@property(nonatomic, readonly) NSArray *inputPorts;

/*!
 @property output
 @abstract
    The AVCaptureOutput instance consuming data from this connection's inputPorts.

 @discussion
    An AVCaptureConnection may involve one or more AVCaptureInputPorts producing data
    to the connection's AVCaptureOutput.  This property is read-only.  An AVCaptureConnection's
    output remains static for the life of the object.  
*/
@property(nonatomic, readonly) AVCaptureOutput *output;

/*!
 @property enabled
 @abstract
    Indicates whether the connection's output should consume data.

 @discussion
    The value of this property is a BOOL that determines whether the receiver's output should consume data 
    from its connected inputPorts when a session is running. Clients can set this property to stop the 
    flow of data to a given output during capture.  The default value is YES.  
*/
@property(nonatomic, getter=isEnabled) BOOL enabled;

/*!
 @property active
 @abstract
    Indicates whether the receiver's output is currently capable of consuming
    data through this connection.

 @discussion
    The value of this property is a BOOL that determines whether the receiver's output
    can consume data provided through this connection.  This property is read-only.  Clients
    may key-value observe this property to know when a session's configuration forces a
    connection to become inactive.  The default value is YES.  
*/
@property(nonatomic, readonly, getter=isActive) BOOL active;

/*!
 @property audioChannels
 @abstract
    An array of AVCaptureAudioChannel objects representing individual channels of
    audio data flowing through the connection.

 @discussion
    This property is only applicable to AVCaptureConnection instances involving
    audio.  In such connections, the audioChannels array contains one AVCaptureAudioChannel
    object for each channel of audio data flowing through this connection.
*/
@property(nonatomic, readonly) NSArray *audioChannels;

/*!
 @property supportsVideoMirroring
 @abstract
    Indicates whether the connection supports setting the videoMirrored property.

 @discussion
    This property is only applicable to AVCaptureConnection instances involving
    video.  In such connections, the videoMirrored property may only be set if
    -isVideoMirroringSupported returns YES.
*/
@property(nonatomic, readonly, getter=isVideoMirroringSupported) BOOL supportsVideoMirroring;

/*!
 @property videoMirrored
 @abstract
    Indicates whether the video flowing through the connection should be mirrored
    about its vertical axis.

 @discussion
    This property is only applicable to AVCaptureConnection instances involving
    video.  if -isVideoMirroringSupported returns YES, videoMirrored may be set
    to flip the video about its vertical axis and produce a mirror-image effect.
*/
@property(nonatomic, getter=isVideoMirrored) BOOL videoMirrored;

/*!
 @property supportsVideoOrientation
 @abstract
    Indicates whether the connection supports setting the videoOrientation property.

 @discussion
    This property is only applicable to AVCaptureConnection instances involving
    video.  In such connections, the videoOrientation property may only be set if
    -isVideoOrientationSupported returns YES.
*/
@property(nonatomic, readonly, getter=isVideoOrientationSupported) BOOL supportsVideoOrientation;

/*!
 @property videoOrientation
 @abstract
    Indicates whether the video flowing through the connection should be rotated
    to a given orientation.

 @discussion
    This property is only applicable to AVCaptureConnection instances involving
    video.  If -isVideoOrientationSupported returns YES, videoOrientation may be set
    to rotate the video buffers being consumed by the connection's output.  Note that
    setting videoOrientation does not necessarily result in a physical rotation of
    video buffers.  For instance, a video connection to an AVCaptureMovieFileOutput
    handles orientation using a Quicktime track matrix.  In the AVCaptureStillImageOutput,
    orientation is handled using Exif tags.
*/
@property(nonatomic) AVCaptureVideoOrientation videoOrientation;

@end



@class AVCaptureAudioChannelInternal;

/*!
 @class AVCaptureAudioChannel
 @abstract
	AVCaptureAudioChannel represents a single channel of audio flowing through 
    an AVCaptureSession.
 
 @discussion
     An AVCaptureConnection from an input producing audio to an output receiving audio
     exposes an array of AVCaptureAudioChannel objects, one for each channel of audio
     available.  Iterating through these audio channel objects, a client may poll
     for audio levels. Instances of AVCaptureAudioChannel cannot be created directly.
*/
NS_CLASS_AVAILABLE(10_7, 4_0)
@interface AVCaptureAudioChannel : NSObject
{
@private
	AVCaptureAudioChannelInternal *_internal;
}

/*!
 @property averagePowerLevel
 @abstract
    A measurement of the instantaneous average power level of the audio
    flowing through the receiver.

 @discussion
    A client may poll an AVCaptureAudioChannel object for its current
    averagePowerLevel to get its instantaneous average power level in decibels.
    This property is not key-value observable.
*/
@property(nonatomic, readonly) float averagePowerLevel;

/*!
 @property peakHoldLevel
 @abstract
    A measurement of the peak/hold level of the audio flowing through the receiver.

 @discussion
    A client may poll an AVCaptureAudioChannel object for its current
    peakHoldLevel to get its most recent peak hold level in decibels.
    This property is not key-value observable.
*/
@property(nonatomic, readonly) float peakHoldLevel;

@end
