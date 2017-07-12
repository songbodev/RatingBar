//
//  ViewController.m
//  RatingBarDemo
//
//  Created by songbo on 15/10/22.
//  Copyright © 2015年 上海电信理想集团. All rights reserved.
//

#import "ViewController.h"
#import "SONGRatingBar.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SONGRatingBar *ratingBarStoryBoard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ratingBarStoryBoard.normalStarImageName = @"ratingInactive";
    self.ratingBarStoryBoard.highlightedStarImageName = @"ratingActive";
    self.ratingBarStoryBoard.rating = 3;
    self.ratingBarStoryBoard.margin = 20.0;
    [self.ratingBarStoryBoard addTarget:self action:@selector(ratingChange:) forControlEvents:UIControlEventValueChanged];
    
    SONGRatingBar *ratingBar = [[SONGRatingBar alloc]initWithFrame:CGRectMake(100, 200, 90, 17)];
    ratingBar.normalStarImageName = @"ratingInactive";
    ratingBar.highlightedStarImageName = @"ratingActive";
    ratingBar.rating = 3;
    ratingBar.isIndicator = NO;
    [ratingBar addTarget:self action:@selector(ratingChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:ratingBar];
}

- (void)ratingChange:(SONGRatingBar *)ratingBar{
    NSLog(@"%f",ratingBar.rating);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
