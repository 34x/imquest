//
//  QuestItem.h
//  image_quest
//
//  Created by Max on 26.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestItem : NSObject
@property (nonatomic,strong) NSString *img;
@property (nonatomic, strong) NSArray *answers;
@property BOOL answered;
@property int tryCount;
@property int index;

+ (id)initWithData:(NSString*)img :(NSArray*)answers;
@end
