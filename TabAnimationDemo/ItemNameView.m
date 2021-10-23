//
//  MyTestCell.h
//  TabAnimationDemo
//
//  Created by wv on 2021/10/23.
//

#import "ItemNameView.h"
#import <Masonry/Masonry.h>

@implementation ItemNameView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - Properties


/// 商品名称标签
- (UITextView *)itemNameTextView {
    if (!_itemNameTextView) {
        _itemNameTextView = [UITextView new];
        _itemNameTextView.textContainer.lineFragmentPadding = 0;                    /// 内容缩进（去除左右边距）
        _itemNameTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);        /// 文本边距（去除上下边距）
        _itemNameTextView.textContainer.maximumNumberOfLines = 2;                   /// 最多 2 行
        _itemNameTextView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;/// 超出显示省略号
        _itemNameTextView.userInteractionEnabled = NO;
//        _itemNameTextView.textColor = WKC_HEXRGBCOLOR(0x333333);
//        _itemNameTextView.font = BBTFont_Regular(14);
    }
    return _itemNameTextView;
}

- (void)setupUI {
    [self addSubview:self.itemNameTextView];
    
//    _WeakSelf(ws)
    
    [self.itemNameTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
    }];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
