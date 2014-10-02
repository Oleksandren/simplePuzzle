//
//  ImageList.m
//  Crop
//
//  Created by OleksandrNechet on 03.02.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "ImageList.h"
#import "ImageListCell.h"
#import "PlayScreen.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define PlayGameSegue @"PlayGameSegue"


@interface ImageList () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSArray *contentData;
}

@end

@implementation ImageList

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    contentData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DefaultImages" ofType:@"plist"]];
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 1000; i++)
        [arr addObjectsFromArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DefaultImages" ofType:@"plist"]]];
    contentData = [NSArray arrayWithArray:arr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction's

- (IBAction)takePhoto:(id)sender
{
    UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
    pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerLibrary.delegate = self;
    [self presentViewController:pickerLibrary animated:YES completion:nil];
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:NO completion:nil];
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self performSegueWithIdentifier:PlayGameSegue sender:pickedImage];
}

#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:PlayGameSegue] && [sender isKindOfClass:[UIImage class]])
    {
        PlayScreen *vc = (PlayScreen *)[segue destinationViewController];
        vc.currentImage = sender;
    }
}

#pragma mark - UICollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return contentData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageListCell" forIndexPath:indexPath];
    [cell setImageWithPath:contentData[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionView Delegate Flow Layout

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *currentImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:contentData[indexPath.row] ofType:@"png"]];
    [self performSegueWithIdentifier:PlayGameSegue sender:currentImage];
}

@end
