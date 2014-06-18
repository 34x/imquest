//
//  PackViewController.m
//  image_quest
//
//  Created by Max on 13.04.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "PackViewController.h"

@interface PackViewController ()

@end

@implementation PackViewController

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
    float width = self.view.bounds.size.width;
    
//    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
    
    NSArray *packList = [[NSArray alloc] initWithObjects:@"Cоветские фильмы", @"Голливудяне", @"Неизвестные лица", @"Маевцы", @"Ребята с нашего двора", @"Герои комиксов", @"Исторические личности", @"Доисторические личности", nil];
    

    
    for (int i = 0; i < packList.count; i++) {
        UILabel *buttonIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, i*50 + self.baseTopPadding+10.0f, 20.0f, 44.0f)];
        [buttonIndexLabel setText:[NSString stringWithFormat:@"%i", i]];
        buttonIndexLabel.alpha = 0.2f;
        [self.view addSubview:buttonIndexLabel];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitle:[packList objectAtIndex:i] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(width/8, i*50.0f + self.baseTopPadding + 10.0f, width - width/4, 44.0f);
        button.tag = i;
        button.contentEdgeInsets = UIEdgeInsetsMake(width /8, 10, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [progress setCenter:CGPointMake(0.0f, i*50.0f)];
        progress.frame = CGRectMake(0.0f, i*50.0f + self.baseTopPadding + 50.0f, width, i*50.0f);
        
        [progress setProgress:0.1f*i];
        [progress setProgressTintColor:[UIColor greenColor]];

//        progress.
        [button addTarget:self action:@selector(selectPack:) forControlEvents:UIControlEventTouchUpInside];
//        button.enabled = NO;
        [self.view addSubview:progress];
        [self.view addSubview:button];
//        [table insertSubview:button atIndex:i];
    }
    
//    [self.view addSubview:table];
}

- (void) selectPack:(UIButton*) sender
{
//    self.nextQuestion = sender.tag;
    [self performSegueWithIdentifier:@"select_image" sender:self];
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
