//
//  ImageListCell.m
//  Crop
//
//  Created by OleksandrNechet on 03.02.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "ImageListCell.h"

@implementation ImageListCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setImageWithPath:(NSString *)imgPath
{
    [imageView setImage:[UIImage imageNamed:imgPath]];
}

@end
