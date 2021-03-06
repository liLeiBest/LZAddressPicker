//
//  LZAddressPickerModelDelegate.h
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LZAddressPickerModelDelegate <NSObject>

/// 区域标识
@property (nonatomic, copy) NSString *areaCode;
/// 区域名称
@property (nonatomic, copy) NSString *areaName;
/// 子区域集合
@property (nonatomic, strong) NSArray *children;
/// 是否选中，默认 NO
@property (nonatomic, assign, getter = isSelected) BOOL selected;

@end

typedef NSObject<LZAddressPickerModelDelegate> LZAddressPickerModel;

NS_ASSUME_NONNULL_END
