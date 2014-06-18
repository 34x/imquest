//
//  QuestItem.m
//  image_quest
//
//  Created by Max on 26.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "QuestItem.h"

@implementation QuestItem
+ (id) initWithData:(NSString *)img :(NSArray *)answers {
    QuestItem *item = [[super alloc] init];
    item.tryCount = 0;
    item.img = img;
    item.answers = answers;
    item.answered = false;
    
    return item;
}
@end
