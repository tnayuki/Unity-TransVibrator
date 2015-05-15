//
//  Plugin.m
//  TransVibratorPlugin
//
//  Created by Toru Nayuki on 2014/08/13.
//
//

#import "LTIOUSBManager.h"

#import "TransVibratorUSBDevice.h"

static BOOL _isInitialized = NO;

static id _deviceAddedObserver = nil;

//typedef void (*DebugLogCallback)(const char *message);
//DebugLogCallback _debugLogCallback = NULL;
//
//void ConnectDebugLogCallback(DebugLogCallback callback)
//{
//    _debugLogCallback = callback;
//}

void InitializePlugin()
{
    if (_isInitialized) return;
    
    _deviceAddedObserver = [[NSNotificationCenter defaultCenter] addObserverForName:LTIOUSBDeviceConnectedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        for (TransVibratorUSBDevice *device in note.object) {
            [device createPluginInterface];
            [device createDeviceInterface];
            [device openDevice];
            [device findFirstInterfaceInterface];
        }
    }];
    
    [[LTIOUSBManager sharedInstance] startWithMatchingDictionary:[LTIOUSBManager matchingDictionaryForProductID:0x064f vendorID:0x0b49 objectBaseClass:[TransVibratorUSBDevice class]]];
    
    _isInitialized = YES;
}

void DeinitializePlugin()
{
    [[NSNotificationCenter defaultCenter] removeObserver:_deviceAddedObserver];
    
    for (TransVibratorUSBDevice *device in [LTIOUSBManager sharedInstance].devices) {
        [device vibrateWithStrength:0];
        
        [device destroyInterfaceInterface];
        [device destroyDeviceInterface];
        [device destroyPluginInterface];
    }
    
    [[LTIOUSBManager sharedInstance] stop];
    
    _isInitialized = NO;
}

int CountInternal()
{
    return (int)[[LTIOUSBManager sharedInstance].devices count];
}

void VibrateInternal(int index, unsigned char strength)
{
    if (index < 0) {
        for (TransVibratorUSBDevice *device in [LTIOUSBManager sharedInstance].devices) {
            [device vibrateWithStrength:strength];
        }
    } else if (index < [[LTIOUSBManager sharedInstance].devices count]) {
        TransVibratorUSBDevice *device = [[LTIOUSBManager sharedInstance].devices objectAtIndex:index];
        [device vibrateWithStrength:strength];
    }
}
