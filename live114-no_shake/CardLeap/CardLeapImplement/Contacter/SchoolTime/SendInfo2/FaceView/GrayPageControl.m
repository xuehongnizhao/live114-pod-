//
//  GrayPageControl.m
//
//  Created by blue on 12-9-28.
//  Copyright (c) 2012年 blue. All rights reserved.
//  Email - 360511404@qq.com
//  http://github.com/bluemood
//


#import "GrayPageControl.h"


@implementation GrayPageControl


- (id)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if ( self ) {

        activeImage = [[UIImage imageNamed:@"reddot"] retain];
        inactiveImage = [[UIImage imageNamed:@"huidot"] retain];
        
        [self setCurrentPage:1];
    }
    return self;
}

- (id)initWithFrame:(CGRect)aFrame {
    
	if (self = [super initWithFrame:aFrame]) {

        activeImage = [[UIImage imageNamed:@"reddot"] retain];
        inactiveImage = [[UIImage imageNamed:@"huidot"] retain];
        [self setCurrentPage:1];
	}
	return self;
}


- (void)updateDots {

    for (int i = 0; i < [self.subviews count]; i++) {

        UIImageView* dot = [self.subviews objectAtIndex:i];

        if (i == self.currentPage) {
            
            if ( [dot isKindOfClass:UIImageView.class] ) {
                
                ((UIImageView *) dot).image = activeImage;
            }
            else {
                
                dot.backgroundColor = UIColorFromRGB(0xfb6268);
            }
        }
        else {
            
            if ( [dot isKindOfClass:UIImageView.class] ) {
                ((UIImageView *) dot).image = inactiveImage;
            }
            else {
                dot.backgroundColor = UIColorFromRGB(0xc3c3c3);
            }
        }
    }
}

-(void) setCurrentPage:(NSInteger)page {

    [super setCurrentPage:page];

    [self updateDots];
}


-(void)dealloc {

    [activeImage release];
    [inactiveImage release];

    [super dealloc];
}

@end
