//
//  ImageViewController.m
//  VoIPTest
//
//  Created by JerryYang on 2015/8/26.
//  Copyright (c) 2015年 JerryYang. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController()

@property(strong, nonatomic) NSString *mPath;

@end

@implementation ImageViewController

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    _mPath = path;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Ready to show image");
    
    [super viewWillAppear:animated];
    NSURL *url = [NSURL URLWithString:self.mPath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    NSLog(@"size = %@", NSStringFromCGSize(image.size));
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
    [imgView setImage:image];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = imgView.bounds.size;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [scrollView addSubview:imgView];
    
    [self.view addSubview:scrollView];
}

@end
