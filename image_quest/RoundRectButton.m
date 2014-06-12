//
//  RoundRectButton.m
//  image_quest
//
//  Created by Max on 23.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "RoundRectButton.h"

@implementation RoundRectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //NSLog(@"button init");
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    //NSLog(@"draw button");
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;

//    self.alpha = 0.8f;
}


@end
