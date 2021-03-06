//
//  LZAddressPickerViewController.h
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/2/26.
//

#import <UIKit/UIKit.h>
#import "LZAddressPickerConfigurationModel.h"
#import "LZAddressPickerModelDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZAddressPickerViewController : UIViewController

/// 配置
@property (nonatomic, strong, readonly) LZAddressPickerConfigurationModel *configuration;
/// 子层级数据源回调
@property (nonatomic, copy) void (^childDataSourceForTierCallback)(LZAddressPickerModel *addressModel, void (^completionCallback)(NSArray<LZAddressPickerModel *> *result));
/// 完成回调
@property (nonatomic, copy) void (^completionCallback)(NSArray<LZAddressPickerModel *> *tiers, NSString *tiersString);


/// 实例
+ (instancetype)instance;

/// 展示地址选择器
/// @param target id
/// @param dataSource NSArray
- (void)showPickerWithTarget:(UIViewController *)target addressList:(NSArray *)dataSource;

@end

NS_ASSUME_NONNULL_END
