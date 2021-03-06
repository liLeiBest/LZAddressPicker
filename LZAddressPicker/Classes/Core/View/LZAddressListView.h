//
//  LZAddressListView.h
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/2.
//

#import <UIKit/UIKit.h>
@class LZAddressListView;

NS_ASSUME_NONNULL_BEGIN

@protocol LZAddressListViewDelegate <NSObject>

/// 选择了某条地址
/// @param addressListView  LZAddressListView
/// @param index  索引
/// @param address LZAddressPickerModel
- (void)LZAddressListView:(LZAddressListView *)addressListView
      didSelectRowAtIndex:(NSInteger)index
                ofAdrress:(LZAddressPickerModel *)address;

@end
@interface LZAddressListView : UIView

/// 代理
@property (nonatomic, weak) id<LZAddressListViewDelegate> delegate;
/// 配置
@property (nonatomic, strong) LZAddressPickerConfigurationModel *configuration;


/// 更新数据源
/// @param array NSArray
- (void)updateDataSource:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
