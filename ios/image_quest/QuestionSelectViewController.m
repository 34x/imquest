//
//  HomeViewController.m
//  image_quest
//
//  Created by Max on 26.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "QuestionSelectViewController.h"
#import "GameViewController.h"
#import "QuestItem.h"
#import "QuestItemAnswer.h"
#import "Game.h"
#import "RoundRectButton.h"

@interface QuestionSelectViewController ()
@property Game *game;
@property NSArray *questItems;
@property long nextQuestion;
@property UIScrollView *scroll;
@end

@implementation QuestionSelectViewController

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
    NSLog(@"didload");
    self.game = [Game initWithPoints:100];
    
    self.questItems = [self loadQuestions];
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20.0f, self.baseTopPadding + 10.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [self.view addSubview:self.scroll];
    
    [self drawScroll];
}

- (void)drawScroll
{
    NSLog(@"drawScroll");
    for(UIView *sub in [self.scroll subviews])
    {
        [sub removeFromSuperview];
    }
    float viewWidth = self.view.frame.size.width;
    //    QuestItem *item = [self.questItems objectAtIndex:0];
    
    //    CIImage *cimage = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:item.img ofType:@"jpg"]]];
    
    //    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageWithCIImage:cimage]];
    
    int row = 0;
    int col = 0;
    float buttonSize = viewWidth/4;
    float buttonVSeparator = 20.0f;
    
    for(int i = 0; i < self.questItems.count; i++) {
        col = i % 3;
        if (i> 0 && 0 == i % 3) {
            row++;
        }
        
        RoundRectButton *button = [RoundRectButton buttonWithType:UIButtonTypeRoundedRect];
        float y = row * (buttonSize + buttonVSeparator);
        float x = col * (buttonSize + 20.0f);
        button.frame = CGRectMake(x, y, buttonSize, buttonSize);
//        [button setTitle:[NSString stringWithFormat:@"?", i] forState:UIControlStateNormal];
//        button.layer.cornerRadius = 10;
//        button.layer.borderWidth = 0.4f;
//        button.clipsToBounds = YES;

        [button addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.scroll addSubview:button];

        QuestItem *item = [self.questItems objectAtIndex:i];
        
//        CIVector *cropRect =[CIVector vectorWithX:0 Y:0 Z: 44.0f W: 10];
//        UIImage *uiimage = [self imageWithImage: [UIImage imageWithCIImage:image] convertToSize: buttonSize * 2];

        CIImage *image = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:item.img ofType:@"jpg"]]];
        
        CIImage *cropped = [image imageByCroppingToRect:CGRectMake(100.0f, 100.0f, buttonSize, buttonSize)];
        [button setBackgroundImage:[UIImage imageWithCIImage:cropped] forState:UIControlStateNormal];
        
        if(item.answered) {
           

        } else {
//            [button setBackgroundColor:[UIColor grayColor]];
        }

//        NSLog(@"answered %i", item.answered);
    }

    self.scroll.contentSize = CGSizeMake(viewWidth, (row + 1) * (buttonSize + buttonVSeparator) + buttonSize);
}

- (void)selectImage:(UIButton*)sender
{
    self.nextQuestion = sender.tag;
    [self performSegueWithIdentifier:@"game" sender:self];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"didappear");
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"willappear");
    [self drawScroll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)randomQuest {
    [self performSegueWithIdentifier:@"game" sender:self];
    //json
//    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *items = [self loadQuestions];
    
    NSLog(@"count %lu", items.count);
}

- (NSArray*) loadQuestions {
    NSString *data = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"csv"] encoding:NSUTF8StringEncoding error:NULL];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    NSArray *questions = [data componentsSeparatedByString:@"\n"];
    for(int i = 0; i < questions.count; i++){
        NSArray *fields = [[questions objectAtIndex:i] componentsSeparatedByString:@";"];
        NSString *filename = [fields objectAtIndex:0];
        
        if ([@""  isEqual: filename]) {
            break;
        }
        
        //NSLog(@"file: %@", filename);
        NSArray *answers = [[fields objectAtIndex:1] componentsSeparatedByString:@","];
        NSMutableArray *itemAnswers = [[NSMutableArray alloc] init];
        
        for(int j =0; j < answers.count; j++) {
            NSString *answer = [answers objectAtIndex:j];
            
            //NSLog(@"answer: %@", answer);
            
            NSRange range = [answer rangeOfString:@"!"];
            
           // NSLog(@"isRight? %i", (bool)range.length);
            
            QuestItemAnswer *qiAnswer = [QuestItemAnswer initWithData:[answer stringByReplacingOccurrencesOfString:@"!" withString:@""] :(bool)range.length];
            
            [itemAnswers addObject:qiAnswer];
        }
        
        QuestItem *questItem = [QuestItem initWithData:filename :itemAnswers];
        [items addObject:questItem];
        //NSLog(@"===");
    }
    
    return items;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GameViewController *vc = [segue destinationViewController];
    
//    NSLog(@"items count %lu", items.count);
//    int index = arc4random_uniform((int)self.questItems.count);

    vc.questItem = [self.questItems objectAtIndex:self.nextQuestion];
    vc.game = self.game;
    

    
    // Pass any objects to the view controller here, like...
//    [vc setMyObjectHere:object];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"segue to %@", [segue identifier]);
}


@end
