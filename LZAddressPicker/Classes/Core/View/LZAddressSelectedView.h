//
//  LZAddressSelectedView.h
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/2.
//

#import <UIKit/UIKit.h>
@class LZAddressSelectedView;

NS_ASSUME_NONNULL_BEGIN

@protocol LZAdressSelectedViewDelegate <NSObject>

/// 选中了某项
/// @param addressSelectedView  LZAddressSelectedView
/// @param index  索引
- (void)LZAddressSelectedView:(LZAddressSelectedView *)addressSelectedView
         didSelectItemAtIndex:(NSInteger)index;

@end

@interface LZAddressSelectedView : UIView

/// 代理
@property (nonatomic, weak) id<LZAdressSelectedViewDelegate> delegate;
/// 配置
@property (nonatomic, strong) LZAddressPickerConfigurationModel *configuration;


/// 更新数据源
/// @param array NSArray
- (void)updateDataSource:(NSArray *)array;

/// 更新选中索引
/// @param index NSInteger
- (void)updateSelectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
