//
//  LZAddressPickerConfigurationModel.h
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 地址选择器事件类型
typedef NS_OPTIONS(NSUInteger, LZAddressPickerOptionType) {
    /// 重置
    LZAddressPickerOptionReset = 1 << 0,
    /// 关闭
    LZAddressPickerOptionClose = 1 << 1,
    /// 确定
    LZAddressPickerOptionConfirm = 1 << 2,
    /// 全部
    LZAddressPickerOptionAll = LZAddressPickerOptionReset | LZAddressPickerOptionClose | LZAddressPickerOptionConfirm,
};

@interface LZAddressPickerConfigurationModel : NSObject

// MARK: 外观
/// 标题，默认: 选择区域
@property (nonatomic, copy) NSString *title;
/// 标题字体，默认:  15号 UIFontWeightSemibold
@property (nonatomic, strong) UIFont *titleFont;
/// 标题颜色，默认: 黑色
@property (nonatomic, strong) UIColor *titleTextColor;

/// 选择标题字体，默认: 14号 UIFontWeightRegular
@property (nonatomic, strong) UIFont *selectTitleFont;
/// 选择默认标题，默认: 请选择
@property (nonatomic, copy) NSString *selectDefaultTitle;
/// 选择标题颜色，默认: 红色
@property (nonatomic, strong) UIColor *selectDefaultTitleTextColor;

/// 列表字体，默认: 14号 UIFontWeightRegular
@property (nonatomic, strong) UIFont *listTitleFont;
/// 列表正常文本颜色,，默认: 黑色
@property (nonatomic, strong) UIColor *listTitleTextColor;

/// 选中文本颜色，默认: Red:41.0 / 255.0 green:159.0 / 255.0 blue:247.0 / 255.0
@property (nonatomic, strong) UIColor *selectedTextColor;

// MARK: 功能
/// 高度比例，默认: 屏幕高度的 0.6 倍
@property (nonatomic, assign) CGFloat heightScale;
/// 最大层级数，默认: 0 不限制
@property (nonatomic, assign) NSUInteger maxTiers;
/// 操作权限，默认: LZAddressPickerOptionAll
@property (nonatomic, assign) enum LZAddressPickerOptionType options;


-  (instancetype)init NS_UNAVAILABLE;
/// 默认配置
+ (instancetype)defaultConfiguration;

@end

NS_ASSUME_NONNULL_END
