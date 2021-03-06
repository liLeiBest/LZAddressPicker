//
//  LZAddressToolbarView.m
//  LZAddressPicker
//
//  Created by Dear.Q on 2021/3/2.
//

#import "LZAddressToolbarView.h"

@interface LZAddressToolbarView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIStackView *actionsStackView;
@property (nonatomic, weak) IBOutlet UIButton *actionResetButton;
@property (nonatomic, weak) IBOutlet UIButton *actionCloseButton;
@property (nonatomic, weak) IBOutlet UIButton *actionConfirmButton;

@end
@implementation LZAddressToolbarView

// MARK: - Initialization
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

// MARK: - Setter
- (void)setConfiguration:(LZAddressPickerConfigurationModel *)configuration {
    _configuration = configuration;
    
    self.titleLabel.text = self.configuration.title;
    self.titleLabel.font = self.configuration.titleFont;
    self.titleLabel.textColor = self.configuration.titleTextColor;
    
    if (!(self.configuration.options & LZAddressPickerOptionReset)) {
        self.actionResetButton.hidden = YES;
    }
    if (!(self.configuration.options & LZAddressPickerOptionClose)) {
        self.actionCloseButton.hidden = YES;
    }
    if (!(self.configuration.options & LZAddressPickerOptionConfirm)) {
        self.actionConfirmButton.hidden = YES;
    }
}

// MARK: - Public

// MARK: - UI Action
- (IBAction)resetDidTouch:(id)sender {
    if (self.resetDidTouchCallback) {
        self.resetDidTouchCallback();
    }
}

- (IBAction)closeDidTouch:(id)sender {
    if (self.closeDidTouchCallback) {
        self.closeDidTouchCallback();
    }
}

- (IBAction)confirmDidTouch:(id)sender {
    if (self.confirmDidTouchCallback) {
        self.confirmDidTouchCallback();
    }
}

// MARK: - Private
- (void)setupUI {
    
    [self.actionResetButton setTitle:nil forState:UIControlStateNormal];
    [self.actionCloseButton setTitle:nil forState:UIControlStateNormal];
    [self.actionConfirmButton setTitle:nil forState:UIControlStateNormal];
    [self setButtonImage:[self image:@"toolbar_reset_icon" inBundle:LZAddressPickerBundle] button:self.actionResetButton];
    [self setButtonImage:[self image:@"toolbar_close_icon" inBundle:LZAddressPickerBundle] button:self.actionCloseButton];
    [self setButtonImage:[self image:@"toolbar_confirm_icon" inBundle:LZAddressPickerBundle] button:self.actionConfirmButton];
}

- (void)setButtonImage:(UIImage *)image button:(UIButton *)button {
    [button setImage:image forState:UIControlStateNormal];
}

@end
