//
//  ShowAllImageViewController.m
//  SeeImagePhoto
//
//  Created by wolfman on 14-3-28.
//  Copyright (c) 2014年 WolfMan. All rights reserved.
//

#import "ShowAllImageViewController.h"

// 展示 帖子 图片1 图片2 图片3 图片4
// 展示 图片
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface ShowAllImageViewController ()<UIGestureRecognizerDelegate>
{
    NSMutableArray * myImageUrlArr;
}

@end

@implementation ShowAllImageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView * myScrollView = [[UIScrollView alloc] init];
    myScrollView.frame = self.view.bounds;
    
    [self.view addSubview: myScrollView];
    
    myImageUrlArr = [[NSMutableArray alloc] init];

    
    if (self.iamgeArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"该商家没有上传图片"];
        return;
    }
    
    //保存图片列表
    for(NSDictionary *dic in self.iamgeArray)
    {
        NSString *pic_url = [dic objectForKey:@"pic"];
        [myImageUrlArr addObject:pic_url];
    }
    
    CGRect rect = self.view.frame;
    CGFloat width = (rect.size.width - 50)/4;
    int BtnW = width;
    int BtnWS = 10;
    int BtnX = 10;
    
    int BtnH = width;
    int BtnHS = 10;
    int BtnY = 10;
    
    int i = 0;
    for (i = 0; i < [myImageUrlArr count]; i++ ) {
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake( (BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH );
        imageview.tag = 10000 + i;
        imageview.userInteractionEnabled = YES;
        // 内容模式
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
        [imageview sd_setImageWithURL: [NSURL URLWithString: [myImageUrlArr objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"user"] ];
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
        [myScrollView addSubview: imageview];
    }
    
    int getEndImageYH = (BtnH+BtnHS) *(i/4) + BtnY ;
    
    if ( getEndImageYH > myScrollView.frame.size.height ) {
        myScrollView.contentSize = CGSizeMake( myScrollView.frame.size.width , getEndImageYH );
    }else{
        myScrollView.contentSize = CGSizeMake( myScrollView.frame.size.width , myScrollView.frame.size.height + 1 );
    }
    
}



-(void)BtnClick:(UITapGestureRecognizer *)imageTap{
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [myImageUrlArr count] ];
    for (int i = 0; i < [myImageUrlArr count]; i++) {
        // 替换为中等尺寸图片
        
        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [myImageUrlArr objectAtIndex:i] ];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl]; // 图片路径
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}


@end
