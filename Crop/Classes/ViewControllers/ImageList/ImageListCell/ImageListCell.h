//
//  ImageListCell.h
//  Crop
//
//  Created by OleksandrNechet on 03.02.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *imageView;
}

- (void) setImageWithPath:(NSString *)imgPath;

@end
