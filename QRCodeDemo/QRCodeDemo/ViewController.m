//
//  ViewController.m
//  QRCodeDemo
//
//  Created by 赵富星 on 16/8/18.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "ViewController.h"

#import "UIImage+Custom.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *genralImageView;
@property (weak, nonatomic) IBOutlet UIImageView *colorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;


@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)renderData {
    self.genralImageView.image = [UIImage getGeneralQRCodeImageWithUrl:@"www.baidu.com"];
    self.colorImageView.image = [UIImage getColorQRCodeImageWithUrl:@"www.360.com"
                                                    foregroundColor:[CIColor colorWithRed:1 green:0 blue:0.8]
                                                   backgroundColour:[CIColor colorWithRed:0 green:1 blue:0.4]];
    self.logoImageView.image = [UIImage getLogoImageWithUrl:@"https://www.hao123.com/"
                                                  logoImage:[UIImage imageNamed:@"1019"]
                                                  imageSize:CGSizeMake(80, 80)];
}

@end
