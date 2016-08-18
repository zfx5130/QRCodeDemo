//
//  UIImage+Custom.h
//  QRCodeDemo
//
//  Created by 赵富星 on 16/8/18.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Custom)

//生成原生黑白二维码
+ (UIImage *)getGeneralQRCodeImageWithUrl:(NSString *)url;

//生成颜色二维码
+ (UIImage *)getColorQRCodeImageWithUrl:(NSString *)url
                        foregroundColor:(UIColor *)foregroundColor
                       backgroundColour:(UIColor *)backgroundColour;

//生成logo二维码
+ (UIImage *)getLogoImageWithUrl:(NSString *)url
                       logoImage:(UIImage *)logoImage
                       imageSize:(CGSize)imageSize;
@end
