//
//  UmengSdkPlugin.h
//  panart
//
//  Created by zsly on 16/1/27.
//
//

#import <Cordova/CDV.h>

@interface OperationPlugin : CDVPlugin
- (void)clearBadgeNumber:(CDVInvokedUrlCommand*)command;
- (void)clearLocalCache:(CDVInvokedUrlCommand*)command;
@end
