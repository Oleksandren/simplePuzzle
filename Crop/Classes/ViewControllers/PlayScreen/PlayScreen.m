//
//  Testing.m
//  Crop
//
//  Created by OleksandrNechet on 03.02.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "PlayScreen.h"
#import "PuzzleFactory.h"



@interface PlayScreen () <UIAlertViewDelegate>
{
    __weak IBOutlet UIImageView *mainImageView;
    IBOutletCollection(UIImageView) NSArray *testingImageView;
}

@end

@implementation PlayScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize size = _currentImage.size;
    
    if ((size.height > 600) || (size.width > 600) )
    {
        UIImage *newImg = [PuzzleFactory cropImg:_currentImage tocropRect:CGRectMake(0, 0, 600, 600)];
        _currentImage = newImg;
    }
    else if ((size.height < 600) || (size.width < 600) )
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Invalid Image" message:@"Image must have size 600 x 600 (px) or more! Your picture is small! Please select another image!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
        _currentImage = nil;
    }
    mainImageView.image = _currentImage;
}

#pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - IBActions

-(IBAction)play:(UIButton *)sender
{
    sender.hidden = YES;
    mainImageView.hidden = YES;
    NSInteger count = 0;
    for (UIImage *curentImage in [PuzzleFactory createPuzzleFromImage:mainImageView.image forSize:9])
    {
        UIImageView *tempImageView = testingImageView[count];
        tempImageView.hidden = NO;

        tempImageView.image = nil;
        
        CGRect frame = tempImageView.frame;
        frame.size.height = curentImage.size.height / 2.0;
        frame.size.width = curentImage.size.width / 2.0;
        tempImageView.frame = frame;
        tempImageView.image = curentImage;
        tempImageView.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(puzzleDragged:)];
        [tempImageView addGestureRecognizer:gesture];
        count++;
    }
}

- (void)puzzleDragged:(UIPanGestureRecognizer *)gesture
{
    UIImageView *tempImageView = (UIImageView *)gesture.view;
    [self.view bringSubviewToFront:tempImageView];
    CGPoint translation = [gesture translationInView:tempImageView];
    
    // move puzzle
    tempImageView.center = CGPointMake(tempImageView.center.x + translation.x,
                               tempImageView.center.y + translation.y);
    // reset translation
    [gesture setTranslation:CGPointZero inView:tempImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
