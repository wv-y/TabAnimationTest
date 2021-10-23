//
//  TipsView.h
//  TabAnimationDemo
//
//  Created by wv on 2021/10/23.
//

#import "TipsView.h"

@interface TipsView()


@property(nonatomic,strong)UIView *couponView;
@property(nonatomic,strong)UILabel *memberRewardLabel;
@property(nonatomic,strong)UILabel *promotionLabel;

@end

@implementation TipsView
#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setupActivityViewWithData:(NSArray *)activityList {
//  根据数据设置视图
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
