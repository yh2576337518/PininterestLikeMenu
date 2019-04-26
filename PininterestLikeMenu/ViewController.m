//
//  ViewController.m
//  PininterestLikeMenu
//
//  Created by Tu You on 12/21/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import "ViewController.h"
#import "PininterestLikeMenu.h"
@interface ViewController ()
@property (nonatomic, strong) PininterestLikeMenu *menu;
@property (nonatomic, strong) UIButton *menuButton;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *highlightedArray;
@property (nonatomic, assign) NSInteger selectItem;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.imageArray = @[@"level1",@"level2",@"level3"];
    self.highlightedArray = @[@"level1_highlighted",@"level2_highlighted",@"level3_highlighted"];
    self.selectItem = 0;
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuButton.frame = CGRectMake(150, 250, 40, 40);
    [self.menuButton setImage:[UIImage imageNamed:@"level1_highlighted"] forState:UIControlStateNormal];
    [self.menuButton addTarget:self action:@selector(popPininterestMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.menuButton];
    
}

- (void)showMenu{
    if (!self.menu) {
        self.menu = [[PininterestLikeMenu alloc] initWithImageArr:self.imageArray highlightedArray:self.highlightedArray withStartPoint:self.menuButton.center selectItem:self.selectItem selectedItemBlock:^(NSInteger selectItem) {
            self.selectItem = selectItem;
            [self.menuButton setImage:[UIImage imageNamed:self.highlightedArray[selectItem]] forState:UIControlStateNormal];
            [self.menu hidden];
            self.menu = nil;
        }];
        [self.view addSubview:self.menu];
    }
    [self.menu show];
}

- (void)popPininterestMenu{
    if (!self.menu) {
        [self showMenu];
    }else{
        [self.menu hidden];
        self.menu = nil;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.menu) {
        [self.menu hidden];
        self.menu = nil;
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

@end
