//
//  LZViewController.m
//  LZAddressPicker
//
//  Created by lilei on 03/05/2021.
//  Copyright (c) 2021 lilei. All rights reserved.
//

#import "LZViewController.h"
#import "LZPickerAddressModel.h"

@interface LZViewController ()

@property (nonatomic, weak) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong) NSArray *selectedArray;

@end

@implementation LZViewController

// MARK: - Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.definesPresentationContext = YES;
}

// MARK: - UI Action
- (IBAction)adPickerDidClick:(id)sender {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *jsonArray = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions|NSJSONWritingPrettyPrinted error:nil] mutableCopy];
    NSArray *addressList = [LZPickerAddressModel mj_objectArrayWithKeyValuesArray:jsonArray];
    LZAddressPickerViewController *ctr = [LZAddressPickerViewController instance];
    ctr.configuration.title = @"请选择所在区域";
//    ctr.configuration.options = LZAddressPickerOptionClose;
    ctr.childDataSourceForTierCallback = ^(LZAddressPickerModel * _Nonnull addressModel, void (^ _Nonnull completionCallback)(NSArray * _Nonnull)) {
        completionCallback([(LZPickerAddressModel<LZAddressPickerModelDelegate> *)addressModel child]);
    };
    ctr.completionCallback = ^(NSArray<LZAddressPickerModel *> * _Nonnull tiers, NSString * _Nonnull tiersString) {
        NSLog(@"%@\n%@", tiers, tiersString);
        self.selectedArray = tiers;
        self.addressLabel.text = tiersString;
    };
    [ctr showPickerWithTarget:self addressList:addressList];
}

@end
