//
//  UmengSdkPlugin.m
//  panart
//
//  Created by zsly on 16/1/27.
//
//

#import "OperationPlugin.h"
#import "Operation.h"
#import "APService.h"
@implementation OperationPlugin
- (void)clearBadgeNumber:(CDVInvokedUrlCommand*)command
{
    [APService setBadge: 0];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)clearLocalCache:(CDVInvokedUrlCommand*)command
{
    [Operation removeTmpImages];
}
@end
