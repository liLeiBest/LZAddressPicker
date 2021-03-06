//
//  LZAddressPickerConfigurationModel.m
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/4.
//

#import "LZAddressPickerConfigurationModel.h"

@implementation LZAddressPickerConfigurationModel

// MARK: - Public
+ (instancetype)defaultConfiguration {
    
    LZAddressPickerConfigurationModel *configuration = [LZAddressPickerConfigurationModel new];
    configuration.title = @"选择区域";
    configuration.titleTextColor = [UIColor blackColor];
    configuration.titleFont = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    
    configuration.selectDefaultTitle = @"请选择";
    configuration.selectTitleFont = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    configuration.selectDefaultTitleTextColor = [UIColor redColor];
    
    configuration.listTitleFont = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    configuration.listTitleTextColor = [UIColor colorWithRed:51.0 / 255.0 green:51 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    
    configuration.selectedTextColor = [UIColor colorWithRed:41.0 / 255.0 green:159.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];
    
    configuration.heightScale = 0.6f;
    configuration.maxTiers = 0;
    configuration.options = LZAddressPickerOptionAll;
    return configuration;
}

@end
