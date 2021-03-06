//
//  LZPickerAddressModel.m
//  LZAddressPicker_Example
//
//  Created by Dear.Q on 2021/3/5.
//  Copyright © 2021 lilei. All rights reserved.
//

#import "LZPickerAddressModel.h"

@implementation LZPickerAddressModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"pid" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"child" : [LZPickerAddressModel class]};
}

- (NSString *)areaCode {
    return _pid;
}

- (NSString *)areaName {
    return _name;
}

- (NSArray *)children {
    return _child;
}

@end
