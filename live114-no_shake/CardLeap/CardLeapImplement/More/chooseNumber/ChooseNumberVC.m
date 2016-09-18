//
//  ChooseNumberVC.m
//  ddjddj
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

#import "ChooseNumberVC.h"
@interface ChooseNumberVC()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic)UIScrollView   *indexScrollView;
@property (strong, nonatomic)UIImageView    *adView;
@property (strong, nonatomic)UITextField    *phoneNumber;
@property (strong, nonatomic)UITextField    *vertifyNumber;
@property (strong, nonatomic)UITextField    *carNumber;
@property (strong, nonatomic)UIButton       *getVertifyNumber;
@property (strong, nonatomic)UITextField    *searchTextField;
@property (strong, nonatomic)UIButton       *searchAcion;
@property (strong, nonatomic)UITableView    *normalNumbers;
@property (strong, nonatomic)UITableView    *VIPNumbers;
@property (strong, nonatomic)UIButton       *exchangeNormalNumbers;
@property (strong, nonatomic)UIButton       *exchangeVIPNumbers;
@property (strong, nonatomic)UIButton       *nextStep;
@end

@implementation ChooseNumberVC
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{


    [self.view addSubview:self.indexScrollView];
    [_indexScrollView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_indexScrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_indexScrollView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_indexScrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    [self.indexScrollView addSubview:self.adView];
    [_adView autoSetDimensionsToSize:CGSizeMake(self.view.frame.size.width, 200*LinHeightPercent)];
    [_adView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_adView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    
    UILabel *phoneNumberLabel=[[UILabel alloc]initForAutoLayout];
    [self.indexScrollView addSubview:phoneNumberLabel];
    [phoneNumberLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [phoneNumberLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.adView withOffset:10];
    [phoneNumberLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    phoneNumberLabel.text=@"手机号码";
    
    [self.indexScrollView addSubview:self.phoneNumber];
    
    UILabel *vertifyLabel=[[UILabel alloc]initForAutoLayout];
    
    [self.indexScrollView addSubview:vertifyLabel];
    [vertifyLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [vertifyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumberLabel withOffset:20];
    [vertifyLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    vertifyLabel.text=@"验  证  码";
    
    [self.indexScrollView addSubview:self.vertifyNumber];
    
    [self.vertifyNumber addSubview:self.getVertifyNumber];
    [_getVertifyNumber autoSetDimensionsToSize:CGSizeMake(100, 30)];
    [_getVertifyNumber autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_getVertifyNumber autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UILabel *carNumberLabel=[[UILabel alloc]initForAutoLayout];
    [self.indexScrollView addSubview:carNumberLabel];
    [carNumberLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:vertifyLabel withOffset:20];
    [carNumberLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [carNumberLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    carNumberLabel.text=@"车牌号码";
    
    [self.indexScrollView addSubview:self.carNumber];
}
#pragma mark -- UIScrollViewDelegate

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]init];
    }
    return cell;
}

#pragma mark -- 懒加载

- (UIScrollView *)indexScrollView{
    if (!_indexScrollView) {
        _indexScrollView=[[UIScrollView alloc]initForAutoLayout];
        _indexScrollView.delegate=self;
        _indexScrollView.scrollEnabled=YES;
        _indexScrollView.contentSize=CGSizeMake(0, 10000);
        _indexScrollView.pagingEnabled=NO;
        [_indexScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _indexScrollView;
}
- (UIImageView *)adView{
    if (!_adView) {
        _adView=[[UIImageView alloc]initForAutoLayout];
        _adView.image=[UIImage imageNamed:@"user"];
    }
    return _adView;
}

- (UITextField *)phoneNumber{
    if (!_phoneNumber) {
        _phoneNumber=[[UITextField alloc]initWithFrame:CGRectMake(90, 205*LinHeightPercent, self.view.frame.size.width-90-10, 30) ];
        _phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
        _phoneNumber.placeholder=@"请输入手机号";

    }
    return _phoneNumber;
}

- (UITextField *)vertifyNumber{
    if (!_vertifyNumber) {
        _vertifyNumber=[[UITextField alloc]initWithFrame:CGRectMake(90, 250*LinHeightPercent, self.view.frame.size.width-90-10, 30)];
        _vertifyNumber.borderStyle = UITextBorderStyleRoundedRect;
        _vertifyNumber.placeholder=@"请输入验证码";
    }
    return _vertifyNumber;
}

- (UIButton *)getVertifyNumber{
    if (!_getVertifyNumber) {
        _getVertifyNumber=[[UIButton alloc]initForAutoLayout];
        [_getVertifyNumber addTarget:self action:@selector(getVertifyAction) forControlEvents:UIControlEventTouchUpInside];
        [_getVertifyNumber setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getVertifyNumber.backgroundColor=[UIColor colorWithRed:1.0 green:0.393 blue:0.4597 alpha:1.0];
        _getVertifyNumber.layer.cornerRadius=5;
        
    }
    return _getVertifyNumber;
}

- (void)getVertifyAction{
    
}

- (UITextField *)carNumber{
    if (!_carNumber) {
        _carNumber=[[UITextField alloc]initWithFrame:CGRectMake(90, 295*LinHeightPercent, self.view.frame.size.width-90-10, 30)];
        _carNumber.borderStyle = UITextBorderStyleRoundedRect;
        _carNumber.placeholder=@"请输入车牌号";
    }
    return _carNumber;
}

- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField=[[UITextField alloc]initForAutoLayout];
    }
    return _searchTextField;
}

- (UIButton *)searchAcion{
    if (!_searchAcion) {
        _searchAcion=[[UIButton alloc]initForAutoLayout];
    }
    return _searchAcion;
}

- (UITableView *)normalNumbers{
    if (!_normalNumbers) {
        _normalNumbers=[[UITableView alloc]initForAutoLayout];
        _normalNumbers.delegate=self;
        _normalNumbers.dataSource=self;
    }
    return _normalNumbers;
}

- (UITableView *)VIPNumbers{
    if (!_VIPNumbers) {
        _VIPNumbers=[[UITableView alloc]initForAutoLayout];
        _VIPNumbers.delegate=self;
        _VIPNumbers.dataSource=self;
    }
    return _VIPNumbers;
}

- (UIButton *)exchangeNormalNumbers{
    if (!_exchangeNormalNumbers) {
        _exchangeNormalNumbers=[[UIButton alloc]initForAutoLayout];
        
    }
    return _exchangeNormalNumbers;
}

- (UIButton *)exchangeVIPNumbers{
    if (_exchangeVIPNumbers) {
        _exchangeVIPNumbers=[[UIButton alloc]initForAutoLayout];
        
    }
    return _exchangeVIPNumbers;
}

- (UIButton *)nextStep{
    if (!_nextStep) {
        _nextStep=[[UIButton alloc]initForAutoLayout];
    }
    return _nextStep;
}
@end
