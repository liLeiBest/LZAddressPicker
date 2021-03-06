//
//  LZPickerAddressModel.h
//  LZAddressPicker_Example
//
//  Created by Dear.Q on 2021/3/5.
//  Copyright © 2021 lilei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZPickerAddressModel : NSObject<LZAddressPickerModelDelegate>

@property (nonatomic , copy) NSString *pid;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , strong) NSArray *child;

@property (nonatomic, copy) NSString *areaCode;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, assign, getter = isSelected) BOOL selected;

@end

NS_ASSUME_NONNULL_END
