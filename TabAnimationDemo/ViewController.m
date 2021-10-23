//
//  ViewController.m
//  TabAnimationDemo
//
//  Created by wv on 2021/10/23.
//

#import "ViewController.h"
#import "MyTestCell.h"
#import "TABAnimated.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listDataArray; // 列表数据
@property (nonatomic, strong) NSMutableArray *editDataArray; // 编辑数据
@property (nonatomic, copy)   NSString *lastSortId;
@property (nonatomic, assign) BOOL isEnd;

@end

@implementation ViewController

#pragma mark - Init Methods

- (void)dealloc {

}

- (void)viewDidLoad {
    [self setupUI];
    [self.tableView tab_startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView tab_endAnimation];
     });
}


#pragma mark - Properties
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MyTestCell class] forCellReuseIdentifier:NSStringFromClass([MyTestCell class])];
        _tableView.backgroundColor = [UIColor whiteColor];
        // 初始化tableView骨架屏
        _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[MyTestCell class] cellHeight:130];
        // 过滤过小的动画元素
//        _tableView.tabAnimated.filterSubViewSize = CGSizeMake(10, 15);
        _tableView.tabAnimated.scrollEnabled = NO;
        _tableView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
//            manager.animationsWithIndexs(1, 2, 9, 10, 11).remove();
        };
    }
    return _tableView;
}

- (NSMutableArray *)listDataArray {
    if (!_listDataArray) {
        _listDataArray = [NSMutableArray array];
    }
    return _listDataArray;
}

- (NSMutableArray *)editDataArray {
    if (!_editDataArray) {
        _editDataArray = [NSMutableArray array];
    }
    return _editDataArray;
}

#pragma mark - Public Methods


#pragma mark - 列表加载

#pragma mark - Private Methods
- (void)setupUI {
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTestCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyTestCell class]) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listDataArray.count <= 0) {
        return 0;
    }
    return self.listDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listDataArray.count <= 0) {
        return 0;
    }
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   //
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
   //
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
