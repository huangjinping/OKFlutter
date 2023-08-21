//
//  BXTestChannel.h
//  Runner
//
//  Created by 胡慧杰 on 2023/3/23.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface BXTestChannel : NSObject
+ (instancetype)shareBXTestChannel;
- (void)initWithFlutterViewController:(FlutterViewController *)flutterViewController;

@end

NS_ASSUME_NONNULL_END
