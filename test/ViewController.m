//
//  ViewController.m
//  test
//
//  Created by JerryYang on 2015/8/31.
//  Copyright (c) 2015年 TUTK. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
@property(strong, nonatomic) MPMoviePlayerViewController* mPlayController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(presentMyViewOnPushNotification:)
                                                 name:@"HAS_PUSH_NOTIFICATION"
                                               object:nil];
    
    self.mPlayController = [[MPMoviePlayerViewController alloc]init];
    self.mPlayController.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentMyViewOnPushNotification:(NSNotification *)notification{
    
    NSDictionary* payload = [notification object];
    NSString *fileUrl = payload[@"file"];
    NSLog(@"File url = %@", fileUrl);
    //NSString *token = payload[@"token"];
    NSArray *mime = [payload[@"mime"] componentsSeparatedByString:@"/"];
    
    NSLog(@"Mime = %@", mime);
    
    NSString *typeName = [mime objectAtIndex:0];
    
    if ([typeName isEqualToString:@"image"]) {
        UIViewController *imageController = [[ImageViewController alloc] initWithPath:fileUrl];
        [self.navigationController pushViewController:imageController animated:YES];
    } else if ([typeName isEqualToString:@"video"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url = [NSURL URLWithString:fileUrl];
            
            [self.mPlayController.moviePlayer setContentURL:url];
            [self.mPlayController.moviePlayer play];
            [self presentMoviePlayerViewControllerAnimated:self.mPlayController];
        });
    }
}

@end
