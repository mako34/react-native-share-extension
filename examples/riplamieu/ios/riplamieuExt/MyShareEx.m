//
//  MyShareEx.m
//  riplamieuExt
//
//  Created by manuel on 15/2/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactNativeShareExtension.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTLog.h>

@interface MyShareEx : ReactNativeShareExtension
@end

@implementation MyShareEx

RCT_EXPORT_MODULE();

- (UIView*) shareView {
  NSURL *jsCodeLocation;
  
  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"riplamieu"
                                               initialProperties:nil
                                                   launchOptions:nil];
  rootView.backgroundColor = nil;
  
  // Uncomment for console output in Xcode console for release mode on device:
   RCTSetLogThreshold(RCTLogLevelInfo - 1);
  
  return rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSLog(@"escucho manda mensaje a JS");
  
  
}




- (NSString*)imTheExtension {
  return @"imTheExtension";
}

//-(void)harvestImage:(NSString *)imageURL {
//  NSFileManager *fileManager = [NSFileManager defaultManager];
//  NSData *imgData = [fileManager contentsAtPath:imageURL];
////  UIImage *img = [UIImage imageWithData:imgData];
//
//  NSLog(@"image guid: %@", imageURL);
//
//  // Process Image..
//}

@end
