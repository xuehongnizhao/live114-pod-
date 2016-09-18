//
//  BaseViewController.h
//  CardLeap
//
//  Created by Sky on 14/11/21.
//  Copyright (c) 2014年 Sky. All rights reserved.
//
/**
 *  基础viewcontroller 设置背景图片以及相应的title
 */
#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
/**
 颜色库的值 所有字体的颜色
 */
#define indexTitle 0x444444//商家名称
#define reviewTitle 0x787878//回复的标题颜色
#define addressTitle  0x969595//地址的标题颜色
#define singleTitle 0x606366//单行文本字体
#define tintColors 0x747474//textview textfiled光标显示颜色
/**
 比例拉伸值
 */
#define LinPercent SCREEN_WIDTH/320.0
#define LinHeightPercent SCREEN_HEIGHT/621.0
/*
 *  从RGB获得颜色 0xffffff
 */
@interface BaseViewController : UIViewController

/**
 *  根据ttf文件设置navbar的字体
 *
 *  @param navTitle 文字
 *  @param navFont  文字大小
 */
-(void)setNavBarTitle:(NSString*) navTitle withFont:(CGFloat) navFont;
/**
 隐藏tabbar
 */
-(void)setHiddenTabbar :(BOOL)hidden;
/**
 获取tabbar的状态
 */
-(BOOL)getHiddenTabbar;
/**
 隐藏navigationbar
 */
- (void)followScrollView:(UIView*)scrollableView;
@end
