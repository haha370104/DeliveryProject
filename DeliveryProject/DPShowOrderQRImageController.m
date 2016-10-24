//
//  DPShowOrderQRImageController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPShowOrderQRImageController.h"

#import <CoreImage/CoreImage.h>
#import <Masonry/Masonry.h>

@interface DPShowOrderQRImageController ()

@property (nonatomic, strong) UIImageView *qrCodeImage;

@property (nonatomic, strong) NSString *qrJsonString;

@end

@implementation DPShowOrderQRImageController

#pragma mark - init -

- (instancetype)initWithCodeJsonNSDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        NSString *json = [self dictionaryToJson:dictionary];
        self.qrJsonString = json;
        [self.view addSubview:self.qrCodeImage];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - lifecycle -

- (void)viewDidAppear:(BOOL)animated
{
    self.qrCodeImage.image = [self createQRCodeImageWithString:self.qrJsonString imageSize:300];
}

#pragma mark - private -

- (void)setupConstraints
{
    [self.qrCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.height.equalTo(self.view.mas_height).multipliedBy(0.4f);
    }];
}

- (UIImage *)createQRCodeImageWithString:(NSString *)string imageSize:(CGFloat)imageSize
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];

    // 2. 给滤镜添加数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    [filter setValue:data forKeyPath:@"inputMessage"];

    // 3. 生成二维码
    CIImage *image = [filter outputImage];

    CGRect extent = CGRectIntegral(image.extent);

    CGFloat scale = MIN(imageSize/CGRectGetWidth(extent), imageSize/CGRectGetHeight(extent));

    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];

    // 4. 显示二维码
    return [UIImage imageWithCIImage:image];
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{

    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}

#pragma mark - getter && setter -

- (UIImageView *)qrCodeImage
{
    if (!_qrCodeImage) {
        _qrCodeImage = [[UIImageView alloc] init];
    }
    return _qrCodeImage;
}

@end
