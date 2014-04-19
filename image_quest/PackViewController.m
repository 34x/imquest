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
    
    NSArray *packList = [[NSArray alloc] initWithObjects:@"Cоветские фильмы", @"Голливудяне", @"Неизвестные лица", nil];
    
    for (int i = 0; i < packList.count; i++) {
        UILabel *buttonIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, i*60+100.0f, 20.0f, 44.0f)];
        [buttonIndexLabel setText:[NSString stringWithFormat:@"%i", i]];
        [self.view addSubview:buttonIndexLabel];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:[packList objectAtIndex:i] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(width/8, i*60 + 100.0f, width - width/4, 44.0f);
        button.tag = i;
        
        [button addTarget:self action:@selector(selectPack:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
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
