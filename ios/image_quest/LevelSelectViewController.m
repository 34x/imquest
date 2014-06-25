//
//  SelectLevelViewController.m
//  image_quest
//
//  Created by Max on 23/06/14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "LevelSelectViewController.h"
#import "ListItem.h"

@interface LevelSelectViewController ()
@property NSArray *packList;
@end

@implementation LevelSelectViewController

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
    
    //    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    self.packList = [[NSArray alloc] initWithObjects:
                     [ListItem initWith : @"Level 1" value: .2],
                     [ListItem initWith : @"Level 2" value: .12],
                     [ListItem initWith : @"Level 3" value: .1],
                     [ListItem initWith : @"Hardmode" value: .5],
                     nil
                     ];
    
    [self drawList:self.packList actionTarget:self actionSelector:@selector(selectLevel:)];
}

- (void) selectLevel:(UIButton*) sender
{
    //    self.nextQuestion = sender.tag;
    //    NSLog(@"go to %i", sender.tag);
    [self performSegueWithIdentifier:@"question_select" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
