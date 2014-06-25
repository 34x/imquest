//
//  PackViewController.m
//  image_quest
//
//  Created by Max on 13.04.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "TopicSelectViewController.h"
#import "ListItem.h"

@interface TopicSelectViewController ()
@property NSArray *packList;
@end

@implementation TopicSelectViewController

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
    
//    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
    
    self.packList = [[NSArray alloc] initWithObjects:
                         [ListItem initWith : @"Cоветские фильмы" value: .2],
                         [ListItem initWith : @"Голливудяне" value: .12],
                         [ListItem initWith : @"Неизвестные лица" value: .1],
                         [ListItem initWith : @"Маевцы" value: .5],
                         [ListItem initWith : @"Ребята с нашего двора" value: .87],
                         [ListItem initWith : @"Герои комиксов" value: .66],
                         [ListItem initWith : @"Исторические личности" value: .47],
                         [ListItem initWith : @"Доисторические личности" value: .36],
                         nil
                    ];

    [self drawList:self.packList actionTarget:self actionSelector:@selector(selectPack:)];
    
//    [self.view addSubview:view];
}

- (void) selectPack:(UIButton*) sender
{
//    self.nextQuestion = sender.tag;
//    NSLog(@"go to %i", sender.tag);
    [self performSegueWithIdentifier:@"level_select" sender:self];
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
