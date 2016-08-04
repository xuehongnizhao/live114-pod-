//
//  shopTakeCateInfo.m
//  CardLeap
//
//  Created by lin on 12/29/14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import "shopTakeCateInfo.h"
#import "dishCateInfo.h"

@implementation shopTakeCateInfo

-(id)initWithDictionary :(NSDictionary*)dict
{
    if (!self) {
        self = [[shopTakeCateInfo alloc] init];
    }
    _review_num = [NSString stringWithFormat:@"%@",dict[@"review_num"]];
    _shop_address = [NSString stringWithFormat:@"%@",dict[@"shop_address"]];
    _shop_take_desc = [NSString stringWithFormat:@"%@",dict[@"shop_take_desc"]];
    _ship_price = [NSString stringWithFormat:@"%@",dict[@"shipp_price"]];
    _num = [NSString stringWithFormat:@"%@",dict[@"num"]];
    _shop_id = [NSString stringWithFormat:@"%@",dict[@"shop_id"]];
    _begin_price = [NSString stringWithFormat:@"%@",dict[@"begin_price"]];
    _shop_pic = [NSString stringWithFormat:@"%@",dict[@"shop_pic"]];
    _shop_name = [NSString stringWithFormat:@"%@",dict[@"shop_name"]];
    _accept_time = [NSString stringWithFormat:@"%@",dict[@"accept_time"]];
    _shipping = [NSString stringWithFormat:@"%@",dict[@"shipping"]];
    _timely = [NSString stringWithFormat:@"%@",dict[@"timely"]];
    _is_ship = [NSString stringWithFormat:@"%@",dict[@"is_ship"]];
    _score = [NSString stringWithFormat:@"%@",dict[@"score"]];
    _share_url = [NSString stringWithFormat:@"%@",dict[@"share_url"]];
    NSMutableArray *arrayCate=[NSMutableArray array];
    
    NSArray *array = dict[@"cate"];
    for (NSDictionary *dic in array) {
        dishCateInfo *info = [[dishCateInfo alloc] initWithDictionary:dic];
        [arrayCate addObject:info];
    }
    _cate = arrayCate;
    return self;
}

@end
