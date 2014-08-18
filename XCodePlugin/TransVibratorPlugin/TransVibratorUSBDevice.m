//
//  TransVibratorUSBDevice.m
//  TransVibratorPlugin
//
//  Created by Toru Nayuki on 2014/08/13.
//
//

#import "TransVibratorUSBDevice.h"

@implementation TransVibratorUSBDevice

+ (NSString *)deviceIdentifier:(io_service_t)device
{
    io_string_t pathName;
    IORegistryEntryGetPath(device, kIOServicePlane, pathName);

    return [NSString stringWithUTF8String:pathName];
}

+ (BOOL)removeFromDeviceListOnDisconnect
{
    return YES;
}

- (void)vibrateWithStrength:(unsigned char)strength
{
    IOUSBDevRequestTO request;
    request.bmRequestType = 0x41;
    request.bRequest = 0x00;
    request.wValue = strength;
    request.wIndex = 0;
    request.wLength = 0;
    request.pData = NULL;
    request.noDataTimeout = 0;
    request.completionTimeout = 1000;
    
    [self sendControlRequestToPipe:0 request:request];
}

@end
