//
//  BaseViewController.m
//  image_quest
//
//  Created by Max on 20/04/14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "BaseViewController.h"
#import "ListItem.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
+ (bool) is7
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] > 6.1f;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    self.baseTopPadding = 0.0f;
    if (version > 6.1f) {
        self.baseTopPadding = 60.0f;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) drawList:(NSArray *)items actionTarget:(id)actionTarget actionSelector:(SEL)actionSelector
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    
    for (int i = 0; i < items.count; i++) {
        ListItem *item = [items objectAtIndex:i];
        
        float baseY = i*54.0f + self.baseTopPadding + 20.0f;
        
        UILabel *buttonIndexLabel = [[UILabel alloc] init];
        [buttonIndexLabel setText:[NSString stringWithFormat:@"%i", i]];
        
        UILabel *buttonChevron = [[UILabel alloc] init];
        [buttonChevron setText:@">"];
        [buttonChevron setTextColor:[UIColor blueColor]];
        
        buttonIndexLabel.alpha = 0.1f;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

        [button setTitle:item.text forState:UIControlStateNormal];
        

        
        
        button.tag = i;
        [button addSubview:buttonChevron];
        //        button.contentEdgeInsets = UIEdgeInsetsMake(width /8, 0, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        button.layer.borderColor = [[UIColor blackColor] CGColor];
        //        button.layer.borderWidth = 1.0f;
        
        UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        
        [progress setProgress:item.value];
        [progress setProgressTintColor:[UIColor greenColor]];
        //        [progress setProgressTintColor:[UIColor blueColor]];
        
        [button addTarget:actionTarget action:actionSelector forControlEvents:UIControlEventTouchUpInside];
        //        button.enabled = NO;
        
        buttonIndexLabel.frame = CGRectMake(15.0f, baseY, 20.0f, 44.0f);
        
        button.frame = CGRectMake(self.view.frame.size.width/10, baseY, self.view.frame.size.width, 44.0f);
        buttonChevron.frame = CGRectMake(button.frame.size.width - 70.0f, 0.0f, 44.0f, 44.0f);
        progress.frame = CGRectMake(0.0f, baseY + 44.0f, self.view.frame.size.width, 44.0f);
        
        
        [view addSubview:buttonIndexLabel];
        [view addSubview:progress];
        [view addSubview:button];
        //        [table insertSubview:button atIndex:i];
    }
    
    scroll.showsVerticalScrollIndicator = YES;
    [scroll setContentSize:CGSizeMake(self.view.frame.size.width, items.count * 56.0f + self.baseTopPadding)];
    [scroll setContentOffset:CGPointMake(0, 0)];
    [scroll addSubview:view];
    [self.view addSubview:scroll];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
