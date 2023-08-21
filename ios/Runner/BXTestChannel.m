//
//  BXTestChannel.m
//  Runner
//
//  Created by 胡慧杰 on 2023/3/23.
//

#import "BXTestChannel.h"
@interface BXTestChannel()
@property(nonatomic, strong)FlutterViewController * flutterViewController;
@property(nonatomic, strong)FlutterMethodChannel * methodChannel;
@property(nonatomic, copy)FlutterResult flutterResult;

@end
@implementation BXTestChannel

-(void)initWithFlutterViewController:(FlutterViewController *)flutterViewController{
    BXTestChannel.shareBXTestChannel.flutterViewController = flutterViewController;
        BXTestChannel.shareBXTestChannel.methodChannel = [FlutterMethodChannel
                                                        methodChannelWithName:@"com.okflutter.connection"
                                                        binaryMessenger:flutterViewController.binaryMessenger];


    NSLog(@"初始化成功了");
       [BXTestChannel.shareBXTestChannel.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
           NSLog(@"%@---%@",call.method,call.arguments);
           if([@"com.okflutter.changeMethod" isEqualToString:call.method]) {
               NSString *param = call.arguments[@"test"];
               NSString * str = [NSString stringWithFormat:@"%s%@","iosString:",param];
               result(str);
              
           
               //延迟2秒主动发消息给flutter
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self sendMsgToFlutter];
                });
               
               
               
           } else {
               result(FlutterMethodNotImplemented);
           }
       }];
}

//ios给flutter发消息
- (void)sendMsgToFlutter{
    
    NSDictionary *dict = @{@"key1":@"Hello",@"key2":@"World"};
    
    [BXTestChannel.shareBXTestChannel.methodChannel invokeMethod:@"com.okflutter.changeMethod" arguments:dict];
    
}



+ (instancetype)shareBXTestChannel {
    static BXTestChannel * _launageChannel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _launageChannel = [[super allocWithZone:NULL] init];
    });
    return _launageChannel;
}





@end
