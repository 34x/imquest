//
//  SelectVariantViewController.m
//  image_quest
//
//  Created by Max on 22.03.14.
//  Copyright (c) 2014 Max. All rights reserved.
//

#import "SelectVariantViewController.h"
#import "RoundRectButton.h"
#import "QuestItemAnswer.h"
#import "Game.h"

@implementation SelectVariantViewController
{
    UIActivityIndicatorView *waitIndicator;
    float currentBlur;
    CIContext *context;
    UIImageView * imageBlock;
    UIView *variantsBlock;
    NSMutableArray *variantButtons;
    BOOL hintUsed;
    Game *game;
    UIBarButtonItem *navRightButton;
    long points;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"initwithnib");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"did load view with questItem");
    
    points = 100;
    
    UIButton *titleLabel = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [titleLabel setTitle:@" Игра" forState:UIControlStateNormal];
    titleLabel.frame = CGRectMake(0, 0, 70, 44);
//    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [titleLabel addTarget:self action:@selector(touchNavTitle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabel;
    
    navRightButton = [[UIBarButtonItem alloc] initWithTitle:@"ОЧК" style:UIBarButtonItemStylePlain target:self action:@selector(touchNavRight:)];
    
    [self updatePoints:self.game.points];
    
    self.navigationItem.rightBarButtonItem = navRightButton;
    
    variantButtons = [[NSMutableArray alloc] init];
    
    hintUsed = NO;
    
    imageBlock = [[UIImageView alloc] init];
    imageBlock.frame = CGRectMake(0.0f, 60.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:imageBlock];

    
    UITapGestureRecognizer *tapDoubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDouble:)];
    tapDoubleRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapDoubleRecognizer];
    
    
    
    // image processing indicator
    waitIndicator = [[UIActivityIndicatorView alloc ] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [waitIndicator setCenter:CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height / 2.0)];
    
    [self.view addSubview:waitIndicator];
    
    currentBlur = 15;

    [self drawImage:currentBlur];
    
    variantsBlock = [[UIView alloc] init];
    
    variantsBlock.frame = CGRectMake(0.0f, self.view.bounds.size.height - 118, self.view.bounds.size.width, 118.0f);
    [variantsBlock setBackgroundColor: [UIColor whiteColor]];
    variantsBlock.alpha = 0.8f;
//    variantsBlock.opaque = NO;
    [self.view addSubview:variantsBlock];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] init];
    [swipeRight addTarget:self action:@selector(swipeVariantsBlock:)];
    [variantsBlock addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] init];
    [swipeLeft addTarget:self action:@selector(swipeVariantsBlock:)];
    [swipeLeft setDirection:    UISwipeGestureRecognizerDirectionLeft];
    [variantsBlock addGestureRecognizer:swipeLeft];
    

    int yOffset = 0;
    
//    [UIButton buttonWithType:UIButtonTypeInfoLight]
    
    for(int i=0; i < self.questItem.answers.count; i++){
        RoundRectButton *button = [RoundRectButton buttonWithType:UIButtonTypeRoundedRect];
        
        QuestItemAnswer *answer = (QuestItemAnswer*)[self.questItem.answers objectAtIndex:i];
        
        NSString *name = answer.name;
        
        [button setTitle:name forState:UIControlStateNormal];
        button.tag = i;
        float y = 10 + (yOffset * 54);
        
        button.frame = CGRectMake(5.0 + (i % 2 * 160), y, 150.0, 44.0);
//        button.backgroundColor = [UIColor greenColor];
        [button.layer setBorderWidth:0.4f];
        //тут можно посмотреть на длинну заголовка и сделать шрифт поменьше
        //    name.length
        //max 17 symbols
        if(name.length > 15) {
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:[UIFont buttonFontSize]-20.0f]];
        }
        [button addTarget:self action:@selector(selectVariant:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [variantsBlock addSubview:button];
        
        if (0 != i % 2) {
            yOffset++;
        }
        
        [variantButtons addObject:button];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
//    NSGregorianCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [[NSDate alloc] init];
    NSLog(@"time %f", [date timeIntervalSince1970] );

    if(![defaults boolForKey:@"startup_help_showed"])
    {
        [self showHelp];
        [defaults setInteger:1 forKey:@"startup_help_showed"];
        [defaults synchronize];
    }
    

    
}

- (void)touchNavTitle :(id)sender
{
    [self showHelp];
}

- (void)touchNavRight :(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Окошко" message:@"Ну что вы тут растыкались, не готово еще" delegate:nil cancelButtonTitle:@"Больше не буду :(" otherButtonTitles:nil];
    
    [alert show];
}

- (void)updatePoints:(long)points
{
        navRightButton.title = [NSString stringWithFormat:@"%lu ОЧК", points];
}

- (void)showHelp
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Помогайка" message:@"Нажмите на картинку дважды, чтобы сделать изображение четче\n\nСмахните блок ответов, чтобы убрать лишние варианты" delegate:nil cancelButtonTitle:@"я запомню!" otherButtonTitles:nil];
    
    [alert show];

}

- (void)swipeVariantsBlock:(id)sender
{
    NSLog(@"slide");
    [self useHint];
}

-(void)selectVariant:(UIButton*)sender
{
    QuestItemAnswer *answer = [self.questItem.answers objectAtIndex:sender.tag];
    
    NSString *title;
    NSString *msg;
    if (answer.isRight) {
//        AlertView *alert = [AlertView create:@"Правильный вариант!"];
        
//        [alert targetForAction:@selector(selectRight) withSender:self];
        title = @"Верный ответ";
        msg = @"Молодчинка!";
        self.questItem.answered = YES;
        self.game.points += points;
    } else {
        title = @"Хреновый ответ :(";
        msg = @"повезет в другой раз";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"кнопка" otherButtonTitles:nil];
    [alert show];
    
    self.questItem.tryCount++;
    
    [self updatePoints:self.game.points];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"ok %ld", (long)buttonIndex);
    [self.navigationController popToRootViewControllerAnimated:true];
}

-(void)drawImage:(float)blur
{
    [waitIndicator startAnimating];
    
    dispatch_queue_t myQueue = dispatch_queue_create("image processing", NULL);
    
    dispatch_async(myQueue, ^{
    NSNumber *blurValue = [NSNumber numberWithFloat:blur];
    
    if(nil == context){
        context = [CIContext contextWithOptions:nil];               // 1
    }
    CIImage *image =
    
    [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.questItem.img ofType:@"jpg"]]];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];           // 3
    
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue: blurValue forKey:kCIInputRadiusKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];              // 4
        
    CGRect extent = [result extent];
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];   // 5
    
    //        iu.image = [UIImage imageWithCGImage:cgImage];
    
    
    UIImage *uiimage = [self imageWithImage: [UIImage imageWithCGImage:cgImage] convertToSize: imageBlock.frame.size];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [waitIndicator stopAnimating];
//            self.view.backgroundColor = [UIColor colorWithPatternImage:uiimage];
            imageBlock.image = uiimage;
            currentBlur = blur;
        });
        
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(variantsBlock.hidden) {
        variantsBlock.hidden = NO;
    } else {
        variantsBlock.hidden = YES;
    }
}

- (void) tapDouble:(UITapGestureRecognizer*)event
{
    if(currentBlur > 0) {
        [self drawImage:currentBlur - 5.0f];
        points = points - 20;
    }
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        [self useHint];
    }
}

- (void) useHint
{
    if(hintUsed && points >= 50)
    {
        return;
    }
    
    points -= 50;
    
    // сначала проверить, что можно использовать подсказку
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.questItem.answers.count; i++)
    {
        QuestItemAnswer *answer = [self.questItem.answers objectAtIndex:i];

        if(NO == answer.isRight)
        {
            [buttons addObject:[variantButtons objectAtIndex:i]];
        }
    }
    
    UIButton *button = [buttons objectAtIndex:arc4random_uniform((int)buttons.count)];
    button.hidden = YES;
    [buttons removeObject:button];
    
    button = [buttons objectAtIndex:arc4random_uniform((int)buttons.count)];
    button.hidden = YES;

    
    [buttons removeAllObjects];
    NSLog(@"use hint");
    hintUsed = YES;
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
