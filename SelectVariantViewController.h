//
//  SelectVariantViewController.h
//  image_quest
//
//  Created by Max on 22.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestItem.h"
#import "Game.h"

@interface SelectVariantViewController : UIViewController<UIAlertViewDelegate> 
@property QuestItem *questItem;
@property Game *game;

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;
- (void)drawImage:(float)blur;
- (void)selectVariant:(UIButton *)sender;
@end
