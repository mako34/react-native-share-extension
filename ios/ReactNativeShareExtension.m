#import "ReactNativeShareExtension.h"
#import "React/RCTRootView.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define ITEM_IDENTIFIER (NSString *)kUTTypeItem
#define CONTENT_IDENTIFIER (NSString *)kUTTypeContent

NSExtensionContext* extensionContext;

@implementation ReactNativeShareExtension {
    NSTimer *autoTimer;
    NSString* type;
    NSString* value;
    NSString* origin;
    
}

- (UIView*) shareView {
    return nil;
}

RCT_EXPORT_MODULE();


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //object variable for extension doesn't work for react-native. It must be assign to gloabl
    //variable extensionContext. in this way, both exported method can touch extensionContext
    extensionContext = self.extensionContext;
    
    UIView *rootView = [self shareView];
    if (rootView.backgroundColor == nil) {
        rootView.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0.1];
    }
    
    //find files on path
    //    [self listAllFiles];
    
    self.view = rootView;
}



RCT_EXPORT_METHOD(close) {
    [extensionContext completeRequestReturningItems:nil
                                  completionHandler:nil];
}



RCT_EXPORT_METHOD(openURL:(NSString *)url) {
  UIApplication *application = [UIApplication sharedApplication];
  NSURL *urlToOpen = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  [application openURL:urlToOpen options:@{} completionHandler: nil];
}



RCT_REMAP_METHOD(data,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if (extensionContext != nil) {
        [self extractDataFromContext: extensionContext withCallback:^(NSString* val, NSString* contentType, NSException* err) {
            if(err) {
                reject(@"error", err.description, nil);
            } else {
                NSLog(@"tha contentType:%@", contentType);
                NSLog(@"tha val:%@", val);
                
                resolve(@{
                          @"type": contentType,
                          @"value": val,
                          @"origin": @"iOS_extension"
                          });
            }
        }];
    } else {
        resolve(@{
                  @"type": @"",
                  @"value": @"",
                  @"origin": @"JS",
                  });
    }
}

- (void)extractDataFromContext:(NSExtensionContext *)context withCallback:(void(^)(NSString *value, NSString* contentType, NSException *exception))callback {
    @try {
        
        NSLog(@"inputs: %ld", context.inputItems.count);
        NSLog(@"input items:: %@", context.inputItems);
        
        NSExtensionItem *item = [context.inputItems firstObject];
        NSArray *attachments = item.attachments;
        __block NSItemProvider *objProvider = nil;
        __block NSString *objIdentifier = nil;
        
        
        [attachments enumerateObjectsUsingBlock:^(NSItemProvider *provider, NSUInteger idx, BOOL *stop) {
            objProvider = provider;
            if ([provider hasItemConformingToTypeIdentifier:ITEM_IDENTIFIER]) {
                objIdentifier = ITEM_IDENTIFIER;
                *stop = YES;
            } else if ([provider hasItemConformingToTypeIdentifier:CONTENT_IDENTIFIER]) {
                objIdentifier = CONTENT_IDENTIFIER;
                *stop = YES;
            }
        }];
        
        if (objProvider != nil && objIdentifier != nil) {
            [objProvider loadItemForTypeIdentifier:objIdentifier options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                NSURL *url = (NSURL *)item;
                
                // check file exists!
                
                //                NSLog(@"URLByResolvingSymlinksInPath :%@", [url URLByResolvingSymlinksInPath].absoluteString);
                //                NSLog(@"URLByResolvingSymlinksInPath :%@", [url URLByResolvingSymlinksInPath]);
                //                NSLog(@"absoluteString :%@", url.absoluteString);
                
                
                
                //                if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]){
                //
                //                    long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:[url path] error:nil][NSFileSize] longLongValue];
                //                    NSLog(@"exists with size: %lld", fileSize);
                //
                //                    NSData* data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
                //
                //                    NSLog(@"file data:: \n%@", data);
                //
                //                    }else{
                //                        NSLog(@" file doesnt exist");
                //                    }
                
                callback([[url URLByResolvingSymlinksInPath] path], objIdentifier, nil);
            }];
        } else {
            callback(@"", @"", nil);
        }
    }
    @catch (NSException *exception) {
        if(callback) {
            callback(nil, nil, exception);
        }
    }
}




//- (void)listAllFiles {
//
//    //----- LIST ALL FILES -----
//    NSLog(@"LISTING ALL FILES FOUND");
//
//    int Count;
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains
//    (NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//
//    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
//    for (Count = 0; Count < (int)[directoryContent count]; Count++)
//    {
//        NSLog(@"File %d: %@", (Count + 1), [directoryContent objectAtIndex:Count]);
//    }
//}

@end
