//
//  PuzzleFactory.m
//  Crop
//
//  Created by OleksandrNechet on 03.02.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "PuzzleFactory.h"
#import "UIImage+Trim.h"

@implementation PuzzleFactory

+ (NSArray *)createPuzzleFromImage:(UIImage *)image forSize:(NSInteger)size
{
    NSMutableArray *result = [NSMutableArray new];
    for (int i = 1; i< size +1; i++)
    {
        UIImage *noCropImg = [PuzzleFactory maskImage:image withMask:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i_%ld", i, size] ofType:@"png"]]];
        UIImage *semiTransparentCrop = [noCropImg imageByTrimmingTransparentPixelsRequiringFullOpacity:NO];
        [result addObject:semiTransparentCrop];
    }
    return result;
}

#pragma mark - Helpers

/**
 Обрезание по маске кусков
 */
+ (UIImage *) maskImage:(UIImage *)image withMask:(UIImage *)maskImage
{
	CGImageRef maskRef = maskImage.CGImage;
    
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
	CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
	return [UIImage imageWithCGImage:masked];
}

+ (UIImage *) cropImg:(UIImage *)originalImage tocropRect:(CGRect)cropRect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], cropRect);
    // or use the UIImage wherever you like
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropImage;
}

@end
