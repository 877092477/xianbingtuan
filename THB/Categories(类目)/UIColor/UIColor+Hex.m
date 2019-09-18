//
//  UIColor+Hex.m
//  我的优选  页面
//
//  Created by 贾宸穆 on 15/9/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color
{
  //删除字符串中的空格
  NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  // String should be 6 or 8 characters
  if ([cString length] < 6)
  {
    return [UIColor clearColor];
  }
  // strip 0X if it appears
  //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
  if ([cString hasPrefix:@"0X"])
  {
    cString = [cString substringFromIndex:2];
  }
  //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
  if ([cString hasPrefix:@"#"])
  {
    cString = [cString substringFromIndex:1];
  }
  if ([cString length] != 6 && [cString length] != 8)
  {
    return [UIColor clearColor];
  }
  
  // Separate into r, g, b substrings
  NSRange range;
  range.location = 0;
  range.length = 2;
  //r
  NSString *rString = [cString substringWithRange:range];
  //g
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  //b
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  
  // Scan values
  unsigned int r, g, b, a;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    //a
    if ([cString length] == 8) {
        range.location = 6;
        NSString *aString = [cString substringWithRange:range];
        
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
    }
  return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1];
}


+ (NSArray*) getRGBWithHexString:(NSString *)color {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return @[@0, @0, @0];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return @[@0, @0, @0];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return @[@(r), @(g), @(b)];
}

+ (UIColor*) calcColorfromColor: (UIColor*)color1 toColor: (UIColor*)color2 withPercent: (CGFloat)percent {
    const CGFloat *components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat *components2 = CGColorGetComponents(color2.CGColor);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < 4; index++) {
        [array addObject: @(components1[index] + (components2[index] - components1[index]) * percent)];
    }
    return [UIColor colorWithRed:[array[0] doubleValue] green:[array[1] doubleValue] blue:[array[2] doubleValue] alpha:[array[3] doubleValue]];
}

@end
