//
//  LZAddressPickerView.h
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/1.
//

#import <UIKit/UIKit.h>
@class LZAddressPickerView;

NS_ASSUME_NONNULL_BEGIN

@protocol LZAddressPickerViewDelegate <NSObject>

/// 返回对应层级的数据列表
/// @param addressPickerView  LZAddressPickerView
/// @param address  LZAddressPickerModel
/// @param handler  完成回调
- (void)LZAddressPickerView:(LZAddressPickerView *)addressPickerView
           didSelectAddress:(LZAddressPickerModel *)address
         completionCallback:(void (^)(NSArray<LZAddressPickerModel *> *result))handler;

@required

/// 选择完成回调
/// @param addressPickerView  LZAddressPickerView
/// @param completeArray  地址列表
/// @param completeString  地址列表描述
- (void)LZAddressPickerView:(LZAddressPickerView *)addressPickerView
              completeArray:(NSArray<LZAddressPickerModel *> *)completeArray
             completeString:(NSString *)completeString;

@end

@interface LZAddressPickerView : UIView

/// 代理
@property (nonatomic, weak) id<LZAddressPickerViewDelegate> delegate;
/// 配置
@property (nonatomic, strong) LZAddressPickerConfigurationModel *configuration;
/// 关闭回调
@property (nonatomic, copy) void (^closeDidTouchCallback)(void);


/// 更新数据源
/// @param array NSArray
- (void)updateDataSource:(NSArray<LZAddressPickerModel *> *)array;

@end

NS_ASSUME_NONNULL_END
