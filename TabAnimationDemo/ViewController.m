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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listDataArray; // 列表数据
@property (nonatomic, strong) NSMutableArray *editDataArray; // 编辑数据
@property (nonatomic, copy)   NSString *lastSortId;
@property (nonatomic, assign) BOOL isEnd;

@property (nonatomic, strong) UICollectionView *collectionV;

@end

@implementation ViewController

#pragma mark - Init Methods

- (void)dealloc {

}

- (void)viewDidLoad {
    [self setupUI];
    
//    [self.tableView tab_startAnimation];
    self.tableView.hidden = YES;
    
    [self.collectionV tab_startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionV tab_endAnimation];
//        [self.collectionV reloadData];
     });
}

#pragma mark - Properties
- (UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.backgroundColor = [UIColor whiteColor];
        
        [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
        _collectionV.tabAnimated = [TABCollectionAnimated animatedWithCellClass:[UICollectionViewCell class] cellSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 100) animatedCount:5];
        _collectionV.tabAnimated.scrollEnabled = NO;

    }
    return _collectionV;
}

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
    [self.view addSubview:self.collectionV];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willDisplayCell: %ld", (long)indexPath.item);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    [self removeAllSubviews:cell.contentView];
    UILabel *label = [UILabel new];
    label.text = [[NSString alloc] initWithFormat:@"index:%ld", (long)indexPath.item];
    label.frame = CGRectMake(10, 10, 200, 50);
    [cell.contentView addSubview:label];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 80);
}

- (void)removeAllSubviews:(UIView *)view
{
    while (view.subviews.count) {
        [view.subviews.lastObject removeFromSuperview];
    }
}

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
