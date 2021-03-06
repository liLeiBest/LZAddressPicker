//
//  LZAddressSelectedView.m
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/2.
//

#import "LZAddressSelectedView.h"

@interface LZAddressSelectedCollectionCell : UICollectionViewCell

@property (nonatomic, strong) LZAddressPickerModel *addressModel;
@property (nonatomic, strong) LZAddressPickerConfigurationModel *configuration;

@end
@interface LZAddressSelectedCollectionCell()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end
@implementation LZAddressSelectedCollectionCell

// MARK: - Initialization
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

// MARK: - Setter
- (void)setAddressModel:(LZAddressPickerModel *)addressModel {
    _addressModel = addressModel;
    
    self.titleLabel.font = self.configuration.selectTitleFont;
    if ([addressModel conformsToProtocol:@protocol(LZAddressPickerModelDelegate)]) {
        
        self.titleLabel.text = _addressModel.areaName;
        self.titleLabel.textColor = self.configuration.selectedTextColor;
    } else {
        
        self.titleLabel.text = self.configuration.selectDefaultTitle;
        self.titleLabel.textColor = self.configuration.selectDefaultTitleTextColor;
    }
}

// MARK: - Private
- (void)setupUI {
    
}

@end

@interface LZAddressSelectedView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIView *animationLineView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *animationLineViewX;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *animationLineViewWidth;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end
@implementation LZAddressSelectedView

// MARK: - Lazy Loading
- (NSMutableArray *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

// MARK: - Initialization
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

// MARK: - Public
- (void)updateDataSource:(NSArray *)array {
    if (self.dataSource.count) {
        [self.dataSource removeAllObjects];
    }
    [self.dataSource addObjectsFromArray:array];
    [self.collectionView reloadData];
}

- (void)updateSelectIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    LZAddressSelectedCollectionCell *cell = (LZAddressSelectedCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [self updateAnimationLineAnimation:cell];
}

// MARK: - Private
- (void)setupUI {
    
    self.animationLineView.hidden = YES;
}

- (void)updateAnimationLineAnimation:(LZAddressSelectedCollectionCell *)cell {
    
    self.animationLineView.hidden = NO;
    CGRect cellRect = [self.collectionView convertRect:cell.frame toView:self.collectionView];
    CGRect convertRect = [self.collectionView convertRect:cellRect toView:self];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.animationLineViewX.constant = convertRect.origin.x;
        self.animationLineViewWidth.constant = convertRect.size.width;
    }];
}

// MARK: - Delegate
// MARK: <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LZAddressSelectedCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LZAddressSelectedCollectionCell" forIndexPath:indexPath];
    cell.configuration = self.configuration;
    cell.addressModel = self.dataSource[indexPath.row];
    if ((indexPath.row ==  self.dataSource.count - 1)) {
        [self updateAnimationLineAnimation:cell];
    }
    return cell;
}

// MARK: <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(LZAddressSelectedView:didSelectItemAtIndex:)]) {
        [self.delegate LZAddressSelectedView:self didSelectItemAtIndex:indexPath.row];
    }
    LZAddressSelectedCollectionCell *cell = (LZAddressSelectedCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [self updateAnimationLineAnimation:cell];
}

// MARK: <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LZAddressPickerModel *addressModel = self.dataSource[indexPath.row];
    NSString *string = nil;
    if ([addressModel conformsToProtocol:@protocol(LZAddressPickerModelDelegate)]) {
        string = addressModel.areaName;
    } else {
        string = self.configuration.selectDefaultTitle;
    }
    CGFloat witdh = [string sizeWithFont:self.configuration.selectTitleFont maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)].width;
    return CGSizeMake(witdh, collectionView.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

@end
