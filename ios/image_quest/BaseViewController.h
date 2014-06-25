//
//  BaseViewController.h
//  image_quest
//
//  Created by Max on 20/04/14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property float baseTopPadding;
+ (bool) is7;
- (void) drawList:(NSArray*)items actionTarget:(id)actionTarget actionSelector:(SEL)actionSelector;
@end
