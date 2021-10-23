//
//  MyTestCell.h
//  TabAnimationDemo
//
//  Created by wv on 2021/10/23.
//

#import "MyTestCell.h"
#import "ItemNameView.h"
#import "TipsView.h"
#import <Masonry/Masonry.h>

@interface MyTestCell ()

@property (nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) ItemNameView *nameView;
@property(nonatomic, strong) TipsView *tipsView;

@end

@implementation MyTestCell

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self setupUI];
    }
    return self;
}

#pragma mark - Properties
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _containerView;
}

/// 商品名称区域
- (ItemNameView *)nameView {
    if (!_nameView) {
        _nameView = [ItemNameView new];
    }
    return _nameView;
}

/// 商品优惠提示标签区域
- (TipsView *)tipsView {
    if (!_tipsView) {
        _tipsView = [TipsView new];
        _tipsView.clipsToBounds = YES;
    }
    return _tipsView;
}

#pragma mark - Layout Subviews

#pragma mark - Public Methods

+ (CGFloat)viewHeightWithGoodsItemData {
    //
    return 130;
}

#pragma mark - Private Methods
- (void)setupUI {
    [self.contentView addSubview:self.containerView];
//    [self.containerView addSubview:self.collectionItemPictureView];
    [self.containerView addSubview:self.nameView];
    [self.containerView addSubview:self.tipsView];
//    [self.containerView addSubview:self.collectionItemPriceView];
// _WeakSelf(ws)
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo([[UIScreen mainScreen] bounds].size.width);
    }];
    
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(42.5);
    }];
    
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.nameView.mas_bottom).offset(5);
         make.left.equalTo(self.nameView.mas_left);
         make.right.equalTo(self.containerView.mas_right).offset(-5);
         make.height.mas_equalTo(17);
     }];
    
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
