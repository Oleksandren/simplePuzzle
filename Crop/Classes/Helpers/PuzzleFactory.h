//
//  PuzzleFactory.h
//  Crop
//
//  Created by OleksandrNechet on 03.02.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuzzleFactory : NSObject

/**
 @param image Исходная картинка которая будет порезана на пазлы
 @param size Количество пазлов
 @return Массив объектов UIImage
 */
+ (NSArray *)createPuzzleFromImage:(UIImage *) image forSize:(NSInteger)size;
+ (UIImage *) cropImg:(UIImage *)originalImage tocropRect:(CGRect)cropRect;

@end
