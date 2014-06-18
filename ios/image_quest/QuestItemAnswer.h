//
//  QuestItemAnswer.h
//  image_quest
//
//  Created by Max on 26.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestItemAnswer : NSObject
@property NSString *name;
@property BOOL isRight;

+ (id) initWithData :(NSString*)name;
+ (id) initWithData :(NSString*)name :(BOOL)isRight;
@end
