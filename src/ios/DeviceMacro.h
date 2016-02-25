//
//  DeviceMacro.h
//  QSMM
//
//  Created by xukang on 14/12/10.
//  Copyright (c) 2014年 ubersexual. All rights reserved.
//

#ifndef QSMM_DeviceMacro_h
#define QSMM_DeviceMacro_h

/**
 *	@brief	屏幕尺寸
 */
#define SCREEN_HEIGHT [Operation screenSize].height
#define SCREEN_WIDTH  [Operation screenSize].width

#define SCREEN_SCALE  [UIScreen mainScreen].scale

#define HEIGHT_OF_TABBAR    49.0

#define NavgationBarStatusBarHeight(nav) [Operation GetNavigationHeight:nav]

#define DEVICE_SYSTEMVERSION    [[UIDevice currentDevice].systemVersion floatValue]

#define IS_IOS_7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define IS_IOS_8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define IS_IOS_9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height-(double)480 ) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height-(double)568 ) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height-(double)667 ) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height-(double)736 ) < DBL_EPSILON )

#define IS_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define KEY_WINDOW  [UIApplication sharedApplication].keyWindow

#endif
