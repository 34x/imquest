//
//  QuestItemAnswer.m
//  image_quest
//
//  Created by Max on 26.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "QuestItemAnswer.h"

@implementation QuestItemAnswer
- (id) init {
    self = [super init];
    self.isRight = NO;
    
    return self;
}

+ (id) initWithData :(NSString*)name {
    QuestItemAnswer *item = [[QuestItemAnswer alloc] init];
    item.name = name;
    return item;
}

+ (id) initWithData :(NSString*)name :(BOOL)isRight {
    QuestItemAnswer *item = [[QuestItemAnswer alloc] init];
    item.name = name;
    item.isRight = isRight;
    return item;
}
@end
