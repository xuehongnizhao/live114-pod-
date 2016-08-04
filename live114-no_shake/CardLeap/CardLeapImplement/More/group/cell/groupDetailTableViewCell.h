//
//  groupDetailTableViewCell.h
//  CardLeap
//
//  Created by mac on 15/1/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "groupInfo.h"
#import "groupDetailInfo.h"

@protocol purchaseDelegate <NSObject>
-(void)go2PurchaseDelegate;
-(void)callPhone;
@end

@protocol orderGroupCellWebViewHeight <NSObject>
// 下载成功，返回web高度
-(void) webViewDidLoad:(CGFloat )height;
// 下载失败，返回错误信息
-(void) webViewFailLoadWithError:(NSError *)error;
@end

@interface groupDetailTableViewCell : UITableViewCell
@property (assign,nonatomic)id<purchaseDelegate> delegate;
@property (nonatomic, assign) id<orderGroupCellWebViewHeight> webViewHeightDelegate;
-(void)confirgureCell :(groupInfo*)info row:(NSInteger)row section:(NSInteger)section;
-(void)confirgureDetailCell :(groupDetailInfo*)info row:(NSInteger)row section:(NSInteger)section;
@end
