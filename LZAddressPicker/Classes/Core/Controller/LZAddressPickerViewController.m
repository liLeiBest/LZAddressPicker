//
//  LZAddressPickerViewController.m
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/2/26.
//

#import "LZAddressPickerViewController.h"
#import "LZAddressPickerView.h"

@interface LZAddressPickerViewController ()
<LZAddressPickerViewDelegate, LZModalPresentationTranslucentTransitioningDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet LZAddressPickerView *containerView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *containerViewHeight;

@property (nonatomic, strong) LZAddressPickerConfigurationModel *configuration;
@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation LZAddressPickerViewController

// MARK: - Initialization
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.configuration = [LZAddressPickerConfigurationModel defaultConfiguration];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationCustom;
}

- (id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
    return self;
}

// MARK: - Public
+ (instancetype)instance {
    return [self viewControllerFromstoryboard:NSStringFromClass(self) inBundle:LZAddressPickerBundle];
}

- (void)showPickerWithTarget:(UIViewController *)target addressList:(NSArray *)dataSource {
    
    self.dataArray = dataSource;
    [target presentViewController:self animated:YES completion:nil];
}

// MARK: - UI Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    CGPoint currentPoint = [touches.allObjects.firstObject locationInView:self.view];
    CGRect rect = self.containerView.frame;
    if (!CGRectContainsPoint(rect, currentPoint)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// MARK: - Private
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    
    self.containerViewHeight.constant = [UIScreen mainScreen].bounds.size.height * self.configuration.heightScale;
    [self.containerView layoutIfNeeded];
    self.containerView.delegate = self;
    self.containerView.configuration = self.configuration;
    [self.containerView updateDataSource:self.dataArray];
    @lzweakify(self);
    self.containerView.closeDidTouchCallback = ^{
        @lzstrongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

// MARK: - Delegate
// MARK: <UIViewControllerTransitioningDelegate>
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    LZModalPresentationTranslucentTransitioning *transitioning = [[LZModalPresentationTranslucentTransitioning alloc] initWithType:LZModalPresentationTypeShow];
    transitioning.delegate = self;
    return transitioning;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    LZModalPresentationTranslucentTransitioning *transitioning = [[LZModalPresentationTranslucentTransitioning alloc] initWithType:LZModalPresentationTypeDismiss];
    transitioning.delegate = self;
    return transitioning;
}

// MARK: <LZModalPresentationTranslucentTransitioningDelegate>
- (UIView *)contentViewInModalPresentationTranslucentTransitioning:(LZModalPresentationTranslucentTransitioning *)addressPickerTransition {
    return self.containerView;
}

// MARK: - Delegate
// MARK: <LZAddressPickerViewDelegate>
- (void)LZAddressPickerView:(LZAddressPickerView *)addressPickerView
           didSelectAddress:(LZAddressPickerModel *)address
         completionCallback:(void (^)(NSArray<LZAddressPickerModel *> * _Nonnull))handler {
    if (self.childDataSourceForTierCallback) {
        self.childDataSourceForTierCallback(address, handler);
    }
}

- (void)LZAddressPickerView:(LZAddressPickerView *)addressPickerView
              completeArray:(NSArray<LZAddressPickerModel *> *)completeArray
             completeString:(NSString *)completeString {
    if (self.completionCallback) {
        self.completionCallback(completeArray, completeString);
    }
}

@end
