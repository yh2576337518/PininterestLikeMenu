//
//  PininterestLikeMenu.m
//  PininterestLikeMenu
//
//  Created by Tu You on 12/21/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import "PininterestLikeMenu.h"

#define kMaxAngle        M_PI_2
#define kMaxLength       (95)
#define kLength          (75)
#define kBounceLength    (18)
#define kPulseLength     (60)

@interface PininterestLikeMenu ()

@property (nonatomic, strong) NSMutableArray *subMenus;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *highlightedArray;
@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation PininterestLikeMenu

- (id)initWithImageArr:(NSArray *)imageArr highlightedArray:(NSArray *)highlightedArray withStartPoint:(CGPoint)point selectItem:(NSInteger)selectItem selectedItemBlock:(SelectedItemBlock)selectedItemBlock{
    if (self = [super init]){
        self.frame = [UIApplication sharedApplication].keyWindow.frame;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        self.subMenus = [NSMutableArray arrayWithCapacity:0];
        self.imageArr = imageArr;
        self.highlightedArray = highlightedArray;
        point.x = point.x < 20 ? 20 : point.x;
        point.x = point.x > (320 - 20) ? (320 - 20) : point.x;
        self.startPoint = point;
        for (int i = 0; i < self.imageArr.count; i++) {
            PininterestLikeMenuItem *menuItem = [[PininterestLikeMenuItem alloc] initWithImage:[UIImage imageNamed:imageArr[i]] selctedImage:[UIImage imageNamed:highlightedArray[i]] selectedBlock:^(void) {
                self.selectedItemBlock(self.selectItem);
            }];
            if (i == selectItem) {
                menuItem.selected = YES;
            }
            [self.subMenus addObject:menuItem];
            menuItem.center = self.startPoint;
            [self addSubview:menuItem];
            UITapGestureRecognizer *menuItemTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuItemTap:)];
            [menuItem addGestureRecognizer:menuItemTap];
        }
        self.selectedItemBlock = selectedItemBlock;
    }
    return self;
}


#pragma mark ------------------视图显示
- (void)show{
    for (int i = 0; i < self.subMenus.count; i++){
        [self pulseTheMenuAtIndex:i];
    }
}

- (void)pulseTheMenuAtIndex:(int)index{
    UIView *view = (UIView *)self.subMenus[index];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        float radian = [self radianWithIndex:index];
        float y =  (kLength + kBounceLength) * sin(radian);
        float x = (kLength + kBounceLength) * cos(radian);
        view.center = CGPointMake(_startPoint.x + x, _startPoint.y + y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            float radian = [self radianWithIndex:index];
            float y = kLength * sin(radian);
            float x =  kLength * cos(radian);
            view.center = CGPointMake(_startPoint.x + x, _startPoint.y + y);
        } completion:^(BOOL finished) {
        }];
    }];
}

- (float)radianWithIndex:(int)index{
    NSUInteger count = self.subMenus.count;
    // from 3/2 -> 2/2  0 -> 320 (20 -> 300)
    float startRadian = M_PI_2 * 3 - ((self.startPoint.x - 20) / (320 - 20 * 2)) * M_PI_2;
    float step = kMaxAngle / (count - 1);
    float radian = startRadian + index * step;
    return radian;
}


#pragma mark -----------------菜单选项点击
-(void)menuItemTap:(UITapGestureRecognizer *)tap{
    PininterestLikeMenuItem *menuItem = (PininterestLikeMenuItem *)tap.view;
    self.selectItem = [self.subMenus indexOfObject:menuItem];
    if (menuItem.selectedBlock){
        menuItem.selectedBlock();
    }
}


#pragma mark -----------------视图关闭
- (void)hidden{
    __weak typeof(self) weakSelf = self;
//    dispatch_queue_t serialQueue = dispatch_queue_create("disappear", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(serialQueue, ^{
        for (int i = (int)(weakSelf.subMenus.count - 1); i >= 0; i--){
            UIView *view = (UIView *)weakSelf.subMenus[i];
//            dispatch_async(dispatch_get_main_queue(),^{
                [UIView animateWithDuration:0.15 animations:^{
                    view.center = weakSelf.startPoint;
                    view.alpha = 0;
                }];
//            });
        }
//    });
//    dispatch_sync(serialQueue, ^{
//        dispatch_async(dispatch_get_main_queue(),^{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.alpha = 0;
            }completion:^(BOOL finished) {
                [weakSelf removeFromSuperview];
            }];
//        });
//    });
}

@end
