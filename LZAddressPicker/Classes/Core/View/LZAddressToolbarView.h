//
//  LZAddressToolbarView.h
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZAddressToolbarView : UIView

/// 配置
@property (nonatomic, strong) LZAddressPickerConfigurationModel *configuration;
/// 重置点击回调
@property (nonatomic, copy) void (^resetDidTouchCallback)(void);
/// 关闭点击回调
@property (nonatomic, copy) void (^closeDidTouchCallback)(void);
/// 确定点击回调
@property (nonatomic, copy) void (^confirmDidTouchCallback)(void);

@end

NS_ASSUME_NONNULL_END
