//
//  Utils.m
//  dragDoctorClientIOS
//
//  Created by xukang on 14-1-9.
//  Copyright (c) 2014年 ubersexual. All rights reserved.
//

#import "Utils.h"
#import "DeviceMacro.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>
@implementation Utils

//获取斜体
+(UIFont *)GetVariationOfFontWithTrait:(UIFont *)baseFont trait:(CTFontSymbolicTraits) trait
{
    CGFloat fontSize = [baseFont pointSize];
    CFStringRef
    baseFontName = (__bridge CFStringRef)[baseFont fontName];
    CTFontRef baseCTFont = CTFontCreateWithName(baseFontName,
                                                fontSize, NULL);
    CTFontRef ctFont =
    CTFontCreateCopyWithSymbolicTraits(baseCTFont, 0, NULL,
                                       trait, trait);
    NSString *variantFontName =
    CFBridgingRelease(CTFontCopyName(ctFont,
                                     kCTFontPostScriptNameKey));
    
    UIFont *variantFont = [UIFont fontWithName:variantFontName
                                          size:fontSize];
    CFRelease(ctFont);
    CFRelease(baseCTFont);
    return variantFont;
}


+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}

+(NSString *)removeUnescapedCharacter:(NSString *)inputStr
{
    
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];
    
    if (range.location != NSNotFound)
    {
        
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        
        while (range.location != NSNotFound)
        {
            
            [mutable deleteCharactersInRange:range];
            
            range = [mutable rangeOfCharacterFromSet:controlChars];
            
        }
        
        return mutable;
        
    }
    
    return inputStr;
}

+(BOOL)isEmptyObject:(id)object{
    return object == NULL || object == nil  || [object isKindOfClass:[NSNull class]];
}

+(BOOL)isEmptyString:(NSString*)str{
    return str == NULL || str == nil || [@"" isEqualToString:str] || [str isKindOfClass:[NSNull class]];
}


+(NSString *)stringFromDate:(NSDate*)date formate:(NSString*)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    return [formatter stringFromDate:date];
}

+(NSDate *)dateFromString:(NSString*)str formate:(NSString*)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    return [formatter dateFromString:str];
}


/**
 @method 获取指定UIFont和size情况下,计算出传入字符串的自适应文本索引
 @param value 待计算的字符串
 @param font 字体
 @param size 限制字符串显示区域
 @result NSInteger 返回索引
 */
+(NSInteger)getTruncate:(UIFont*)uiFont str:(NSString*)value size:(CGSize)size
{
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)uiFont.fontName, uiFont.pointSize, NULL);
    NSDictionary *attr = [NSDictionary dictionaryWithObject:(__bridge id)ctFont forKey:(id)kCTFontAttributeName];
    CFRelease(ctFont);
    NSAttributedString *attrString  = [[NSAttributedString alloc] initWithString:value attributes:attr];
    CTFramesetterRef frameSetter =CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    CFRange fitRange;
    CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), NULL, CGSizeMake(size.width, size.height), &fitRange);
    CFRelease(frameSetter);
    CFIndex numberOfCharactersThatFit = fitRange.length;
    return numberOfCharactersThatFit;
}


/**
 @method 获取指定宽度情况下，字符串value的高度
 @param value 待计算的字符串
 @param font 字体
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value fontSize:(UIFont*)font andWidth:(float)width
{
    if (IS_IOS_7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGRect rectToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rectToFit.size.height;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
 #pragma clang diagnostic pop
        return sizeToFit.height;
        
    }
    
}


+ (CGFloat) heightForString:(NSString *)value fontSize:(UIFont*)font andWidth:(float)width andLines:(NSInteger)num
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,width,0)];
    label.text=value;
    label.lineBreakMode=NSLineBreakByTruncatingTail;
    label.numberOfLines=num;
    [label sizeToFit];
    
    return label.frame.size.height;
}


+ (float) widthForString:(NSString *)value fontSize:(UIFont*)font andHeight:(float)height{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGRect rectToFit = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rectToFit.size.width;
}



+(UIImage *)imageFromColor:(UIColor*)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  将16进制颜色字符串转换成uicolor
 *
 *  @param
 *
 *  @return
 */
#define DEFAULT_VOID_COLOR [UIColor clearColor]
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}



+(NSComparator)numStrSortAscendingBlock{
    return ^(id str1, id str2)
    {
        int num1 = [str1 intValue];
        int num2 = [str2 intValue];
        if(num1 < num2) return NSOrderedAscending;
        else if (num1 > num2) return NSOrderedDescending;
        else return NSOrderedSame;
    };
}
+(NSComparator)numStrSortDescendingBlock{
    return ^(id str1, id str2)
    {
        int num1 = [str1 intValue];
        int num2 = [str2 intValue];
        if(num1 < num2) return NSOrderedDescending;
        else if (num1 > num2) return NSOrderedAscending;
        else return NSOrderedSame;
    };
}

+(NSString *)jsonFromObject:(NSObject*)obj{
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}


#pragma mark UILabel 自动高度计算
+ (CGSize) labelAutoSize:(NSString *) text maxSize:(CGSize)max font:(UIFont*)_font
{
    return [Utils labelAutoSize:text maxSize:max font:_font lineBreakMode:NSLineBreakByWordWrapping];
}

+ (CGSize) labelAutoSize:(NSString *) text maxSize:(CGSize)max font:(UIFont*)_font lineBreakMode:(NSLineBreakMode)breakMode{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = breakMode;
    NSDictionary *attributes = @{NSFontAttributeName:_font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelsize = [text boundingRectWithSize:max options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelsize;
}

+ (CGSize)AttributedStringAutoSize:(NSAttributedString *)value width:(CGFloat)width lines:(NSInteger)lines font:(UIFont*)_font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,width,CGFLOAT_MAX)];
    label.attributedText = value;
    [label setNumberOfLines:lines];
    label.font = _font;
    label.lineBreakMode=NSLineBreakByTruncatingTail;
    [label sizeToFit];
    return label.frame.size;
}

+ (CGSize)AttributedStringTotalSize:(NSAttributedString *)value width:(CGFloat)width font:(UIFont*)_font
{
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithAttributedString:value];
    
    [attributedString addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0,attributedString.length)];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGSize targetSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [attributedString length]), NULL, targetSize, NULL);
    CFRelease(framesetter);
    return fitSize;
}


+ (NSString*) dateHuman:(NSInteger)datestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:datestamp];
    NSDate *now  = [NSDate date];
    NSDateFormatter *dayFormat = [[NSDateFormatter alloc] init];
    [dayFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *today = [dayFormat dateFromString:[dayFormat stringFromDate:now]];
    NSDate *yesterday = [NSDate dateWithTimeInterval:-86400 sinceDate:today];
    NSDateFormatter *yearFormat = [[NSDateFormatter alloc] init];
    [yearFormat setDateFormat:@"yyyy"];
    NSDate *thisYear = [yearFormat dateFromString:[yearFormat stringFromDate:now]];
//    NSDate *lastYear = [NSDate dateWithTimeInterval:-31557600 sinceDate:today];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    if ([date compare:today] == NSOrderedDescending) { // 今天
        [format setDateFormat:@"今天 HH:mm"];
    }else if ([date compare:yesterday] == NSOrderedDescending) { // 今天
        [format setDateFormat:@"昨天 HH:mm"];
    }else if ([date compare:thisYear] == NSOrderedDescending) { //
        [format setDateFormat:@"MM-dd HH:mm"];
    }else{
        [format setDateFormat:@"yyyy-MM-dd"];
    }
    return [format stringFromDate:date];
}




@end
