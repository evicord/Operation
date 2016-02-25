//
//  Utils.h
//  dragDoctorClientIOS
//
//  Created by xukang on 14-1-9.
//  Copyright (c) 2014年 ubersexual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
@interface Utils : NSObject

/**
 *  MD5加密
 *
 *  @param password
 *
 *  @return
 */
+ (NSString *)md5HexDigest:(NSString*)password;

/**
 *  过滤特殊字符
 *
 *  @param inputStr
 *
 *  @return
 */
+(NSString *)removeUnescapedCharacter:(NSString *)inputStr;
/**
 *  判断字符串是否为空
 *
 *  @param str
 *
 *  @return
 */
+(BOOL)isEmptyString:(NSString*)str;

/**
 *  判断object是否为空
 *
 *  @param object
 *
 *  @return
 */
+(BOOL)isEmptyObject:(id)object;


/**
 *  字符串转换NSDate
 *
 *  @param date
 *  @param formate
 *
 *  @return
 */
+(NSString *)stringFromDate:(NSDate*)date formate:(NSString*)formate;


/**
 *  日期转换字符串
 *
 *  @param str
 *  @param formate
 *
 *  @return 
 */
+(NSDate *)dateFromString:(NSString*)str formate:(NSString*)formate;

///**
// @method 获取指定宽度情况下，字符串value的高度
// @param value 待计算的字符串
// @param font 字体
// @param andWidth 限制字符串显示区域的宽度
// @result float 返回的高度
// */
//+ (float) heightForString:(NSString *)value fontSize:(UIFont*)font andWidth:(float)width;
//
//
///**
// @method 获取指定宽度和行数情况下，字符串value的高度
// @param value 待计算的字符串
// @param font 字体
// @param andWidth 限制字符串显示区域的宽度
// @param lines 指定行数
// @result float 返回的高度
// */
//+ (CGFloat) heightForString:(NSString *)value fontSize:(UIFont*)font andWidth:(float)width andLines:(NSInteger)num;
//
//
//
///**
// @method 获取指定高度的情况下，字符串value的宽度
// @param value 待计算的字符串
// @param font 字体
// @param andHeight 限制字符串显示区域的高度
// @result float 返回的宽度
// */
//+ (float) widthForString:(NSString *)value fontSize:(UIFont*)font andHeight:(float)height;
//
//



/**
 *  从颜色创建图片
 *
 *  @param color
 *  @param size
 *
 *  @return
 */
+(UIImage *)imageFromColor:(UIColor*)color andSize:(CGSize)size;

/**
 *  将16进制颜色字符串转换成uicolor
 *
 *  @param
 *
 *  @return
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha;

/**
 *  返回一个比较数字字符串的block
 *
 *  @return
 */
+(NSComparator)numStrSortAscendingBlock;
+(NSComparator)numStrSortDescendingBlock;


+(NSString *)jsonFromObject:(NSObject*)obj;






#pragma mark UILabel 自动高度计算
+ (CGSize) labelAutoSize:(NSString *) text maxSize:(CGSize)max font:(UIFont*)_font;

+ (CGSize) labelAutoSize:(NSString *) text maxSize:(CGSize)max font:(UIFont*)_font lineBreakMode:(NSLineBreakMode)breakMode;


/**
 * @method 获取指定指定行数，宽度的情况下，字符串value的大小
 * @param value 待计算的字符串
 * @param width 限制字符串显示区域的宽度
 * @param lines 限制字符串显示的行数
 * @param font 字体
 * @result CGSize 返回指定行数的大小
 */
+ (CGSize)AttributedStringAutoSize:(NSAttributedString *)value width:(CGFloat)width lines:(NSInteger)lines font:(UIFont*)_font;

/**
 * @method 获取字符串value的总体大小
 * @param value 待计算的字符串
 * @param width 限制字符串显示区域的宽度
 * @param font 字体
 * @result CGSize 返回的总体大小
 */
+ (CGSize)AttributedStringTotalSize:(NSAttributedString *)value width:(CGFloat)width font:(UIFont*)_font;

/**
 格式化日期
 */
+ (NSString*) dateHuman:(NSInteger)datestamp;





/**
 @method 获取指定UIFont和size情况下,计算出传入字符串的自适应文本索引
 @param value 待计算的字符串
 @param font 字体
 @param size 限制字符串显示区域
 @result NSInteger 返回索引
 */
+(NSInteger)getTruncate:(UIFont*)uiFont str:(NSString*)value size:(CGSize)size;


//获取斜体
+(UIFont *)GetVariationOfFontWithTrait:(UIFont *)baseFont trait:(CTFontSymbolicTraits) trait;
 

@end
