//
//  LZAddressPickerView.m
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/1.
//

#import "LZAddressPickerView.h"
#import "LZAddressToolbarView.h"
#import "LZAddressSelectedView.h"
#import "LZAddressListView.h"

@interface LZAddressPickerView()
<LZAdressSelectedViewDelegate, LZAddressListViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet LZAddressToolbarView *toolbarView;
@property (nonatomic, weak) IBOutlet LZAddressSelectedView *selectedView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *selectedDataArray;

@end

@implementation LZAddressPickerView

// MARK: - Lazy Loading
- (NSMutableArray *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)selectedDataArray {
    if (nil == _selectedDataArray) {
        _selectedDataArray = [NSMutableArray array];
    }
    return _selectedDataArray;
}

// MARK: - Initialization
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:20.0f];
}

// MARK: - Setter
- (void)setConfiguration:(LZAddressPickerConfigurationModel *)configuration {
    _configuration = configuration;
    
    self.toolbarView.configuration = self.configuration;
    self.selectedView.configuration = self.configuration;
    [self.selectedView updateDataSource:@[[NSNull null]]];
}

// MARK: - Public
- (void)updateDataSource:(NSArray<LZAddressPickerModel *> *)array {
    
    [self.dataSource addObject:array];
    [self configAddressListView:array];
}

// MARK: - Private
- (void)setupUI {
    @lzweakify(self);
    self.toolbarView.resetDidTouchCallback = ^{
        @lzstrongify(self);
        if (self.dataSource.count) {
            // 重置选中列表
            [self.selectedDataArray removeAllObjects];
            [self.selectedDataArray addObject:[NSNull null]];
            [self.selectedView updateDataSource:self.selectedDataArray];
            // 重置地址列表
            for (LZAddressListView *view in self.scrollView.subviews) {
                [view removeFromSuperview];
            }
            NSArray *array = [self.dataSource firstObject];
            for (LZAddressPickerModel *address in array) {
                if (address.isSelected) {
                    address.selected = NO;
                }
            }
            [self.dataSource removeAllObjects];
            [self updateDataSource:array];
        }
    };
    self.toolbarView.closeDidTouchCallback = ^{
        @lzstrongify(self);
        if (self.closeDidTouchCallback) {
            self.closeDidTouchCallback();
        }
    };
    self.toolbarView.confirmDidTouchCallback = ^{
        @lzstrongify(self);
        if (self.closeDidTouchCallback) {
            self.closeDidTouchCallback();
        }
        if ([self.delegate respondsToSelector:@selector(LZAddressPickerView:completeArray:completeString:)]) {
            
            NSMutableString *addressStringM = [NSMutableString string];
            for (LZAddressPickerModel *addressModel in self.selectedDataArray) {
                if ([addressModel conformsToProtocol:@protocol(LZAddressPickerModelDelegate)]) {
                    [addressStringM appendString:addressModel.areaName];
                } else {
                    [self.selectedDataArray removeObject:addressModel];
                }
            }
            [self.delegate LZAddressPickerView:self completeArray:self.selectedDataArray completeString:[addressStringM copy]];
        }
    };
    self.selectedView.delegate = self;
    self.scrollView.delegate = self;
}

- (void)configAddressListView:(NSArray *)dataArray {
    
    LZAddressListView *ListView = [[LZAddressListView alloc] initWithFrame:CGRectMake((self.frame.size.width * (self.dataSource.count - 1)), 0, self.frame.size.width, self.scrollView.frame.size.height)];
    ListView.delegate = self;
    ListView.configuration = self.configuration;
    ListView.tag = self.dataSource.count - 1;
    [ListView updateDataSource:dataArray];
    [self.scrollView addSubview:ListView];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.dataSource.count, 0);
    [self.scrollView setContentOffset:CGPointMake((self.frame.size.width * (self.dataSource.count - 1)), 0) animated:YES];
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(LZAddressListView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > self.dataSource.count - 1) {
            [obj removeFromSuperview];
        }
    }];
}

// MARK: - Delegate
// MARK: <LZAdressSelectedViewDelegate>
- (void)LZAddressSelectedView:(LZAddressSelectedView *)selectedView
         didSelectItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * index, 0) animated:NO];
}

// MARK: <LZAddressListViewDelegate>
- (void)LZAddressListView:(LZAddressListView *)addressListView
      didSelectRowAtIndex:(NSInteger)index
                ofAdrress:(LZAddressPickerModel *)address {
    
    self.dataSource = [self.dataSource subarrayWithRange:NSMakeRange(0, index + 1)].mutableCopy;
    self.selectedDataArray  = [self.selectedDataArray subarrayWithRange:NSMakeRange(0, index)].mutableCopy;
    [self.selectedDataArray addObject:address];
    [self.selectedDataArray addObject:[NSNull null]];
    
    if ([self.delegate respondsToSelector:@selector(LZAddressPickerView:didSelectAddress:completionCallback:)]) {
        [self.delegate LZAddressPickerView:self didSelectAddress:address completionCallback:^(NSArray<LZAddressPickerModel *> * _Nonnull array) {
            if (array && array.count > 0) {
                [self updateDataSource:array];
            }
            if ((0 < self.configuration.maxTiers && self.configuration.maxTiers < self.dataSource.count)
                || (nil == array || array.count == 0)) {
                
                [self.selectedDataArray removeLastObject];
                if (self.closeDidTouchCallback) {
                    self.closeDidTouchCallback();
                }
                if ([self.delegate respondsToSelector:@selector(LZAddressPickerView:completeArray:completeString:)]) {
                    
                    NSMutableString *addressStringM = [NSMutableString string];
                    for (LZAddressPickerModel *addressModel in self.selectedDataArray) {
                        [addressStringM appendString:addressModel.areaName];
                    }
                    [self.delegate LZAddressPickerView:self completeArray:self.selectedDataArray completeString:[addressStringM copy]];
                }
            }
            [self.selectedView updateDataSource:self.selectedDataArray];
        }];
    }
}

// MARK: <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
    [self.selectedView updateSelectIndex:index];
}

@end
