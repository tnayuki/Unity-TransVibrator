//
//  TransVibratorUSBDevice.h
//  TransVibratorPlugin
//
//  Created by Toru Nayuki on 2014/08/13.
//
//

#import "LTIOUSBDevice.h"

@interface TransVibratorUSBDevice : LTIOUSBDevice

- (void)vibrateWithStrength:(unsigned char)strength;

@end
