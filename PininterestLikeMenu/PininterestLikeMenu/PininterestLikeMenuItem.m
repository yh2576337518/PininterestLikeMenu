//
//  PininterestLikeMenuItem.m
//  PininterestLikeMenu
//
//  Created by Tu You on 12/21/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import "PininterestLikeMenuItem.h"

@interface PininterestLikeMenuItem ()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation PininterestLikeMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImage:(UIImage *)image selctedImage:(UIImage *)selectedImage selectedBlock:(SelectedBlock)selectedBlock{
    if (self = [super init]){
        
        self.bounds = CGRectMake(0, 0, 40, 33);
        
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.frame = self.bounds;
        self.imageView.image = image;
        self.imageView.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        self.selectedImage = selectedImage;
        
//        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 50, 10)];
//        self.label.text = @"111";
//        self.label.textAlignment = NSTextAlignmentCenter;
//        self.label.font = [UIFont systemFontOfSize:12];
//        [self addSubview:self.label];
        
        self.selectedBlock = selectedBlock;
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (selected) {
        self.imageView.image = self.selectedImage;
    }
}


@end
