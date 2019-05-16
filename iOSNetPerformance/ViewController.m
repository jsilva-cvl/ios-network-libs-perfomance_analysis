//
//  ViewController.m
//  iOSNetPerformance
//
//  Created by José Silva on 16/05/2019.
//  Copyright © 2019 Codavel. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "iOSNetPerformance-Swift.h"

@interface ViewController ()
@property(nonatomic,strong)NewVC *secondVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self nativeLibs];
    //    [self afNetworking];
    [self alamofire];
    
}

-(void)nativeLibs {
    
    long startTime = [[NSDate date] timeIntervalSince1970] * 1000;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    config.URLCache = nil;
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://porto.speedtest.net.zon.pt:8080/speedtest/random750x750.jpg"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else if (data && [data length] > 0) {
            long stopTime = [[NSDate date] timeIntervalSince1970] * 1000;
            NSLog(@"TIME NSURLSession %ld",stopTime-startTime);
        }
    }];
    [dataTask resume];
}

-(void)afNetworking {
    
    long startTime = [[NSDate date] timeIntervalSince1970] * 1000;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    configuration.URLCache = nil;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://porto.speedtest.net.zon.pt:8080/speedtest/random750x7502.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        long stopTime = [[NSDate date] timeIntervalSince1970] * 1000;
        
        NSLog(@"TIME AFNetworking %ld",stopTime-startTime);
        //            NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

-(void)alamofire{
    _secondVC = [[NewVC alloc] init];
    [self presentViewController:_secondVC animated:YES completion:nil];
}
@end
