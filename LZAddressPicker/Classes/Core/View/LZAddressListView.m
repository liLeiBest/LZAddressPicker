//
//  LZAddressListView.m
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/2.
//

#import "LZAddressListView.h"

@interface LZAddressListCellView : UITableViewCell

@property (nonatomic, strong) LZAddressPickerModel *addressModel;
@property (nonatomic, strong) LZAddressPickerConfigurationModel *configuration;


/// 实例
/// @param tableView UITableView
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

@interface LZAddressListCellView()

@end
@implementation LZAddressListCellView

// MARK: - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

// MARK: - Setter
- (void)setAddressModel:(LZAddressPickerModel *)addressModel {
    _addressModel = addressModel;
    
    self.textLabel.text = _addressModel.areaName;
    self.textLabel.font = self.configuration.listTitleFont;
    if (YES == _addressModel.isSelected) {
        self.textLabel.textColor = self.configuration.selectedTextColor;
    } else {
        self.textLabel.textColor = self.configuration.listTitleTextColor;
    }
}

// MARK: - Public
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString *identify = NSStringFromClass(self);
    LZAddressListCellView *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[LZAddressListCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}

// MARK: - Private
- (void)setupUI {
    
}

@end

@interface LZAddressListView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) LZAddressPickerModel *selectedAddressModel;

@end
@implementation LZAddressListView

// MARK: - Lazy Loading
- (UITableView *)tableView {
    if (nil == _tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView setTableFooterView:[UIView new]];
    }
    return _tableView;;
}

- (NSMutableArray *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

// MARK: - Initalization
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

// MARK: - Public
- (void)updateDataSource:(NSArray *)array {
    if (self.dataSource.count) {
        [self.dataSource removeAllObjects];
    }
    [self.dataSource addObjectsFromArray:array];
    [self markSelectedAddress:self.selectedAddressModel];
    [self.tableView reloadData];
}

// MARK: - Private
- (void)setupUI {
    [self addSubview:self.tableView];
}

- (void)markSelectedAddress:(LZAddressPickerModel *)addressModel {
    if (nil == addressModel) {
        return;
    }
    for (LZAddressPickerModel *model in self.dataSource) {
        if ([model.areaCode isEqualToString:addressModel.areaCode]
            && [model.areaName isEqualToString:addressModel.areaName]) {
            model.selected = YES;
        } else {
            model.selected = NO;
        }
    }
}

// MARK: - Delegeate
// MARK: <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZAddressListCellView *cell = [LZAddressListCellView cellWithTableView:tableView];
    cell.configuration = self.configuration;
    cell.addressModel = self.dataSource[indexPath.row];
    return cell;
}

// MARK: <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(LZAddressListView:didSelectRowAtIndex:ofAdrress:)]) {
        
        LZAddressPickerModel *addressModel = self.dataSource[indexPath.row];
        [self markSelectedAddress:addressModel];
        self.selectedAddressModel = addressModel;
        [self.tableView reloadData];
        [self.delegate LZAddressListView:self didSelectRowAtIndex:self.tag ofAdrress:addressModel];
    }
}

@end
