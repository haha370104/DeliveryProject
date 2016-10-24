//
//  DPSubwayPickerController.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPSubwayPickerController;

@protocol DPSubwayPickerControllerDelegate <NSObject>

- (void)DPSubwayPickerController:(DPSubwayPickerController *)controller didSelectedSubwayStation:(NSString *)subwayStation;

@end

@interface DPSubwayPickerController : UIViewController

@property (nonatomic, weak) id<DPSubwayPickerControllerDelegate> delegate;

@end
