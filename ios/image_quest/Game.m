//
//  Game.m
//  image_quest
//
//  Created by Max on 29.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "Game.h"

@implementation Game
+ (id) load
{
    Game *game = [[super alloc] init];
    return game;
}

- (int) getPoints
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (int)[defaults integerForKey:@"game_points"];
}

- (int) addPoints:(int)points
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int currentPoints = [self getPoints];
    int newPoints = currentPoints + points;
    [defaults setInteger:newPoints forKey:@"game_points"];
    
    return newPoints;
}
@end
