//
//  Game.m
//  image_quest
//
//  Created by Max on 29.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "Game.h"

@implementation Game
+ (id) initWithPoints:(long)points
{
    Game *game = [[super alloc] init];
    
    game.points = points;
    return game;
}
@end
