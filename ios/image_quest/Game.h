//
//  Game.h
//  image_quest
//
//  Created by Max on 29.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
@property int scores;
@property long points;
+(id)initWithPoints:(long)points;
@end
