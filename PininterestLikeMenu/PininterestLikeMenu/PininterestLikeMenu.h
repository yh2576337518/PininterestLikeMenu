//
//  PininterestLikeMenu.h
//  PininterestLikeMenu
//
//  Created by Tu You on 12/21/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PininterestLikeMenuItem.h"
typedef void(^SelectedItemBlock)(NSInteger selectItem);
@interface PininterestLikeMenu : UIView

@property (nonatomic, assign) NSInteger selectItem;
@property (nonatomic, copy) SelectedItemBlock selectedItemBlock;

- (id)initWithImageArr:(NSArray *)imageArr highlightedArray:(NSArray *)highlightedArray withStartPoint:(CGPoint)point selectItem:(NSInteger)selectItem selectedItemBlock:(SelectedItemBlock)selectedItemBlock;

- (void)show;

- (void)hidden;

@end
