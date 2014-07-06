//
//  NavigationController.m
//  image_quest
//
//  Created by Max on 06/07/14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "UINavigationViewController.h"

@interface UINavigationViewController ()

@end

@implementation UINavigationViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *levels = [[NSArray alloc] initWithObjects:@"TopicSelectViewController", @"LevelSelectViewController", @"QuestionSelectViewController", @"GameViewController", nil];

    NSArray *segues = [[NSArray alloc] initWithObjects:@"-", @"level_select", @"question_select", @"game", nil];
    
    NSLog(@"push %@", viewController.class);
    [super pushViewController:viewController animated:animated];
    
    int index = [levels indexOfObject:[NSString stringWithFormat:@"%@", viewController.class]];
//    NSLog(@"index: %i", index);
//    return;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *breadcrumbs = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"breadcrumbs"]];
    if (0 == breadcrumbs.count) {
        breadcrumbs = [[NSMutableArray alloc] initWithObjects:
                   [[NSArray alloc] initWithObjects:
                    [levels objectAtIndex:0], [segues objectAtIndex:0], nil], nil];
    }
    
    NSArray *crumb = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@", viewController.class], [segues objectAtIndex:index], nil];
    
    if(breadcrumbs.count > index) {
        [breadcrumbs replaceObjectAtIndex:index withObject:crumb];
    } else {
        [breadcrumbs addObject:crumb];
    }
    
    [defaults setObject:breadcrumbs forKey:@"breadcrumbs"];
    [defaults synchronize];

    NSLog(@"%@", breadcrumbs);

}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *controller = [super popViewControllerAnimated:animated];
    NSLog(@"pop %@", controller.class);

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSMutableArray *breadcrumbs = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"breadcrumbs"]];

    [breadcrumbs removeLastObject];
    [defaults setObject:breadcrumbs forKey:@"breadcrumbs"];
    
    [defaults synchronize];
    NSLog(@"%@", breadcrumbs);
    return controller;
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
