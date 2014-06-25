//
//  ListItem.m
//  image_quest
//
//  Created by Max on 18/06/14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem
+ (id) initWith:(NSString *)text value: (float)value {
    ListItem *item = [[super alloc] init];
    item.text = text;
    item.value = value;
    return item;
}
@end
