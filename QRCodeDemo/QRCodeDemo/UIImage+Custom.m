//
//  UIImage+Custom.m
//  QRCodeDemo
//
//  Created by 赵富星 on 16/8/18.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "UIImage+Custom.h"

@implementation UIImage (Custom)


+ (UIImage *)getGeneralQRCodeImageWithUrl:(NSString *)url {
    
    //创建二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性
    [qrImageFilter setDefaults];
    
    
    //将二维码内容转换为NSData
    NSData *qrImageData = [url dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //但是图片 发现有的小 (27,27),我们需要放大..我们进去CIImage 内部看属性
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
    
    UIImage *image = [UIImage imageWithCIImage:qrImage];
    
    return image;
}

+ (UIImage *)getColorQRCodeImageWithUrl:(NSString *)url
                        foregroundColor:(CIColor *)foregroundColor
                       backgroundColour:(CIColor *)backgroundColour {
    
    NSArray *filterArr = [CIFilter filterNamesInCategories:@[kCICategoryBuiltIn]];   //对
    
    NSLog(@"%@",filterArr); //所有内建过滤器,找CR... 二维码的
    
    //创建二维码过滤器
    CIFilter * qrfilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrfilter setDefaults];
    
    //将字符串转为NSData,去获取图片
    NSData * qrimgardata = [url dataUsingEncoding:NSUTF8StringEncoding];
    
    //去获取对应的图片(因为测试,直接用字符串会崩溃)
    [qrfilter setValue:qrimgardata forKey:@"inputMessage"];
    
    //去获得对应图片 outPut
    CIImage *qrImage = qrfilter.outputImage;
    
    //图片不清除,打印知道其 大小 为 (27,27). 进入 CIImage,看属性,
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
    
    
    //创建彩色过滤器   (彩色的用的不多)-----------------------------------------------------
    CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    
    //设置默认值
    [colorFilter setDefaults];
    
    //同样打印这样的 输入属性  inputKeys
    NSLog(@"%@",colorFilter.inputKeys);
    /*
     inputImage,   //输入的图片
     inputColor0,  //前景色
     inputColor1   //背景色
     */
    
    //KVC 给私有属性赋值
    [colorFilter setValue:qrImage forKey:@"inputImage"];
    
    //需要使用 CIColor
    [colorFilter setValue:foregroundColor forKey:@"inputColor0"];
    [colorFilter setValue:backgroundColour forKey:@"inputColor1"];
    
    //设置输出
    CIImage *colorImage = [colorFilter outputImage];
    
    
    UIImage *image = [UIImage imageWithCIImage:colorImage];
    
    return image;
}


+ (UIImage *)getLogoImageWithUrl:(NSString *)url
                       logoImage:(UIImage *)logoImage
                       imageSize:(CGSize)imageSize {

    NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    NSLog(@"%@",filters);
    
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrImageFilter setDefaults];
    
    NSData *qrImageData = [url dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",qrImageFilter.inputKeys);
    /*
     inputMessage,        //二维码输入信息
     inputCorrectionLevel //二维码错误的等级,就是容错率
     */
    
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    CIImage *qrImage = [qrImageFilter outputImage];
    
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    
    
    //----------------给 二维码 中间增加一个 自定义图片----------------
    UIGraphicsBeginImageContext(qrUIImage.size);
    
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    
    UIImage *sImage = logoImage;
    
    CGFloat sImageW = imageSize.width;
    CGFloat sImageH = imageSize.height;
    CGFloat sImageX = (qrUIImage.size.width - sImageW) * 0.5;
    CGFloat sImgaeY = (qrUIImage.size.height - sImageH) * 0.5;
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return finalyImage;
}

@end
