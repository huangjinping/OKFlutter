//
//  OkFlutterViewController.m
//  Runner
//
//  Created by 胡慧杰 on 2023/3/23.
//

#import "OkFlutterViewController.h"
@interface OkFlutterViewController()
@property (nonatomic, strong) FlutterMethodChannel *pushChannel;
@end
@implementation OkFlutterViewController








-(void)viewDidLoad{
    [super viewDidLoad];
////    UIButton * button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
////    button.frame=CGRectMake(100, 100, 100, 100);
////    button.backgroundColor=[UIColor redColor];
////    [self.view addSubview:button];
    __weak typeof(self) ws = self;
      self.pushChannel = [FlutterMethodChannel methodChannelWithName:@"com.okflutter.connection" binaryMessenger:ws];
      [self.pushChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
          NSLog(@"method  我的方法%@", call.method);
          NSLog(@"%@", result);
          [ws handleFlutterMethod:call result:result];
      }];
}

- (void)handleFlutterMethod:(FlutterMethodCall *)call result:(FlutterResult )result {
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了Cancel");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了OK");
    }];
  
    UIAlertController *alertController=[[UIAlertController alloc] init];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    if ([call.method isEqualToString:@"com.okflutter.changeMethod"]) {
        NSDictionary *dict = @{@"key1":@"Hello",@"key2":@"World"};
        [self.pushChannel invokeMethod:@"com.okflutter.changeMethod" arguments:dict];
    }
}



@end
