//
//  ListItem.h
//  image_quest
//
//  Created by Max on 18/06/14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject
@property (nonatomic,strong) NSString *text;
@property float value;
//@property int total;

+ (id)initWith:(NSString*)text value: (float) value;
@end
