//
//  orderSeatDetailViewController.m
//  CardLeap
//
//  Created by mac on 15/1/12.
//  Copyright (c) 2015年 Sky. All rights reserved.
//
//  订座

#import "orderSeatDetailViewController.h"
#import "orderSeatDetailInfo.h"
#import "orderSeatDetailTableViewCell.h"
#import "ReviewListViewController.h"
#import "orderSeatSubmitViewController.h"
#import "LoginViewController.h"
#import "UMSocial.h"
#import "MapViewController.h"

@interface orderSeatDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UMSocialUIDelegate,orderSeatCellWebViewHeight>
{
    orderSeatDetailInfo *detailInfo;
    CGFloat webHeight;
    BOOL is_finish;
}
@property (strong,nonatomic)UIButton *shareButton;
@property (strong,nonatomic)UIButton *orderButton;
@property (strong,nonatomic)UITableView *orderSeatDetailTableview;
@end

@implementation orderSeatDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self initData];

}

- (void) initData
{
    webHeight = 0;
    is_finish = NO;
    [self getDataFromNet];
}
#pragma mark-------get Data
-(void)getDataFromNet
{
#pragma mark --- 11.24 订座数据接口
    NSString *url = connect_url(@"seat_shop_message");
    NSDictionary *dict = @{
                         @"app_key":url,
                         @"shop_id":self.shop_id
                         };
    [Base64Tool postSomethingToServe:url andParams:dict isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
        if ([param[@"code"] integerValue]==200) {
            detailInfo = [[orderSeatDetailInfo alloc] initWithDictionary:param[@"obj"]];
            [self.orderSeatDetailTableview reloadData];

        }else{
            [SVProgressHUD showErrorWithStatus:param[@"message"]];
        }
    } andErrorBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
}

#pragma mark-------set UI
-(void)setUI
{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.shareButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [self.view addSubview:self.orderButton];
    [_orderButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
    [_orderButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0f];
    [_orderButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0f];
    [_orderButton autoSetDimension:ALDimensionHeight toSize:40.0f];
    
    [self.view addSubview:self.orderSeatDetailTableview];
    [_orderSeatDetailTableview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-1.0f];
    [_orderSeatDetailTableview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [_orderSeatDetailTableview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [_orderSeatDetailTableview autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_orderButton withOffset:-10.0f];
}

#pragma mark-------get UI
-(UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_shareButton setImage:[UIImage imageNamed:@"coupon_share_no"] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"coupon_share_sel"] forState:UIControlStateHighlighted];
        [_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        _shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    }
    return _shareButton;
}

-(UIButton *)orderButton
{
    if (!_orderButton) {
        _orderButton = [[UIButton alloc] initForAutoLayout];
        _orderButton.layer.masksToBounds = YES;
        _orderButton.layer.cornerRadius = 4.0f;
        [_orderButton setTitle:@"立即预定" forState:UIControlStateNormal];
        [_orderButton setTitle:@"立即预定" forState:UIControlStateHighlighted];
        [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_orderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_orderButton setBackgroundColor:UIColorFromRGB(0x79c5d3)];
        [_orderButton addTarget:self action:@selector(submitAtion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderButton;
}

-(UITableView *)orderSeatDetailTableview
{
    if (!_orderSeatDetailTableview) {
        _orderSeatDetailTableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _orderSeatDetailTableview.translatesAutoresizingMaskIntoConstraints = NO;
        _orderSeatDetailTableview.delegate = self;
        _orderSeatDetailTableview.dataSource = self;
        _orderSeatDetailTableview.scrollEnabled = NO;
        [UZCommonMethod hiddleExtendCellFromTableview:_orderSeatDetailTableview];
        if ([_orderSeatDetailTableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_orderSeatDetailTableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if ([_orderSeatDetailTableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_orderSeatDetailTableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
    return _orderSeatDetailTableview;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *telePhone = detailInfo.shop_tel;
    NSArray *array = [telePhone componentsSeparatedByString:@","];
    if (alertView.tag == 1) {
        NSString *tel_one = [array objectAtIndex:0];
        if (buttonIndex == 0) {
            [UZCommonMethod callPhone:tel_one superView:self.view];
        }
    }else if (alertView.tag == 2){
        NSString *tel_one = [array objectAtIndex:0];
        NSString *tel_two = [array objectAtIndex:1];
        if (buttonIndex == 1) {
            [UZCommonMethod callPhone:tel_one superView:self.view];
        }else if (buttonIndex == 2){
            [UZCommonMethod callPhone:tel_two superView:self.view];
        }
    }
}

#pragma mark - web页加载完毕，计算web 高度

-(void) webViewDidLoad:(CGFloat )height
{
    webHeight = height;
    [SVProgressHUD dismiss];
    if (is_finish == NO) {
        is_finish = YES;
        [self.orderSeatDetailTableview reloadData];
        self.orderSeatDetailTableview.scrollEnabled = YES;
    }
}
-(void) webViewFailLoadWithError:(NSError *)error{
    
}
#pragma mark---------tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"干嘛的-----");
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 1) {
            NSLog(@"跳转到评价列表");
            ReviewListViewController *firVC = [[ReviewListViewController alloc] init];
            firVC.shop_id = detailInfo.shop_id;
            firVC.cate_id = @"4";
            firVC.index = @"4";
            [firVC setNavBarTitle:@"评价" withFont:14.0f];
//            [firVC.navigationItem setTitle:@"评价"];
            [self.navigationController pushViewController:firVC animated:YES];
        }
    }else if (section == 1){
        if(row == 0){
            NSLog(@"拨打电话");
            NSLog(@"拨打电话");
            NSString *telePhone = detailInfo.shop_tel;
            NSArray *array = [telePhone componentsSeparatedByString:@","];
            if ([array count]==1) {
                NSString *num = [array objectAtIndex:0];
                [UZCommonMethod callPhone:num superView:self.view];
            }else{
                NSString *tel_one = [array objectAtIndex:0];
                NSString *tel_two = [array objectAtIndex:1];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系商家" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:tel_one, tel_two,nil];
                alert.tag = 2;
                [alert show];
            }
        }
        if (row == 1) {
            if (detailInfo != nil || self.info!= nil) {
                MapViewController *firVC = [[MapViewController alloc] init];
                if (self.info!= nil ) {
                    firVC.addr =self.info.shop_name;
                    firVC.latitude = self.info.shop_lat;
                    firVC.longitude = self.info.shop_lng;
                }else{
                    firVC.addr = detailInfo.shop_name;
                    firVC.latitude = detailInfo.shop_lat;
                    firVC.longitude = detailInfo.shop_lng;
                }
//                firVC.myLat = self.my_lat;
//                firVC.myLnt = self.my_lng;
                [self.navigationController pushViewController:firVC animated:YES];
            }
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CGFloat height = 0.0;
    switch (section) {
        case 0:
            if (row==0) {
                height = 180;
            }else{
                height = 40;
            }
            break;
        case 1:
            height = 40;
            break;
        case 2:
            if (row == 0) {
                height = 40;
            }else{
#pragma mark --- 11.27 这里改为计算web页高度
                //通过计算得到
                if (is_finish == NO) {
                    height = 280.0f;
                }else {
                    height = webHeight;
                }
            }
            break;
        default:
            break;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier=@"order_seat_detail_cell";
    orderSeatDetailTableViewCell *cell=(orderSeatDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil)
    {
        cell = [[orderSeatDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject]removeFromSuperview];
    }
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (detailInfo!= nil) {
        [cell confirgureCell:detailInfo section:section row:row];
    }else{
        if (self.info!=nil) {
            [cell confirgureDetailCell:self.info section:section row:row];
        }
    }
    if (indexPath.section == 2 && indexPath.row != 0) {
        // web页这行加代理
        cell.webViewHeightDelegate = self;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (detailInfo == nil && self.info == nil) {
        return 0;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5f;
}

#pragma mark-------share action
-(void)shareAction:(UIButton*)sender
{
    NSLog(@"分享");
    [self UserSharePoint];
    //NSString *url = @"www.baidu.com";
    NSString *sinaText = [NSString stringWithFormat:@"如e生活 %@",detailInfo.share_url];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:@"如e生活"
                                     shareImage:[UIImage imageNamed:@"shareIcon"]
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone]
                                       delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = detailInfo.shop_name;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = detailInfo.share_url;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = detailInfo.shop_name;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = detailInfo.share_url;
    
    [UMSocialData defaultData].extConfig.qzoneData.title = detailInfo.shop_name;
    [UMSocialData defaultData].extConfig.qzoneData.url = detailInfo.share_url;
    
    [UMSocialData defaultData].extConfig.sinaData.shareText = sinaText;
//    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = detailInfo.share_url;
}
#pragma mark --- 11.28 点击分享按钮就加积分
- (void) UserSharePoint {
    if (ApplicationDelegate.islogin == YES) {
        NSString *url = connect_url(@"share_point");
        NSDictionary *dict = @{
                               @"app_key":url,
                               @"u_id":[UserModel shareInstance].u_id
                               };
        [Base64Tool postSomethingToServe:url andParams:dict isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
            if ([param[@"code"] integerValue]==200) {
//                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            }
        } andErrorBlock:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"您尚未登录，无法给您增加积分"];
    }
}
#pragma mark--------分享回掉方法（弃用）
-(void)didFinishGetUMSocialDataInViewController1:(UMSocialResponseEntity *)response
{
    NSLog(@"分享完成，去执行接口增加积分");
    NSLog(@"进入代理方法");
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
        if (ApplicationDelegate.islogin == YES) {
            NSString *url = connect_url(@"share_point");
            NSDictionary *dict = @{
                                   @"app_key":url,
                                   @"u_id":[UserModel shareInstance].u_id
                                   };
            [Base64Tool postSomethingToServe:url andParams:dict isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
                if ([param[@"code"] integerValue]==200) {
                    [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                }
            } andErrorBlock:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络异常"];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"您尚未登录，无法给您增加积分"];
        }
    }
    else if (response.responseCode == UMSResponseCodeFaild){
        [SVProgressHUD showSuccessWithStatus:@"分享失败"];
    }
}

-(void)submitAtion:(UIButton*)sender
{
    NSLog(@"立即预定");
    if (detailInfo!= nil) {
        if (ApplicationDelegate.islogin == NO) {
            LoginViewController *firVC = [[LoginViewController alloc] init];
            [firVC setHiddenTabbar:YES];
            [firVC setNavBarTitle:@"登录" withFont:14.0f];
//            [firVC.navigationItem setTitle:@"登录"];
            [self.navigationController pushViewController:firVC animated:YES];
        }else{
            orderSeatSubmitViewController *firVC = [[orderSeatSubmitViewController alloc] init];
            [firVC setHiddenTabbar:YES];
            [firVC setNavBarTitle:@"在线预定" withFont:14.0f];
//            [firVC.navigationItem setTitle:@"在线预定"];
            firVC.hintMessage = detailInfo.shop_desc;
            firVC.shop_id = detailInfo.shop_id;
            [self.navigationController pushViewController:firVC animated:YES];
        }
    }
}



@end
