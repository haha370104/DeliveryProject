//
//  DPSubwayPickerController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPSubwayPickerController.h"

#import "NSObject+DPTypeCheck.h"
#import "UIWindow+MainWindow.h"
#import "UIColor+DPTheme.h"

#import <Masonry/Masonry.h>

@interface DPSubwayPickerController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSArray *keysIndex;
@property (nonatomic, strong) NSDictionary *subwayInfo;
@property (nonatomic, strong) NSMutableArray *allStations;
@property (nonatomic, strong) NSMutableArray *filterStations;

@end

@implementation DPSubwayPickerController

#pragma mark - init -

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.tableView];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - UISearchResultsUpdating -

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.filterStations removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchController.searchBar.text];
    self.filterStations = [[self.allStations filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.filterStations.count) {
        return 1;
    }
    return self.subwayInfo.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.filterStations.count) {
        return self.filterStations.count;
    }
    NSString *key = [self.keysIndex objectAtIndex:section];
    return [self.subwayInfo arrayValueForKey:key].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];

    if (self.filterStations.count) {
        cell.textLabel.text = [self.filterStations objectAtIndex:indexPath.row];
        return cell;
    }

    NSString *key = [self.keysIndex objectAtIndex:indexPath.section];
    NSString *subwayStationName = [[self.subwayInfo arrayValueForKey:key] objectAtIndex:indexPath.row];
    cell.textLabel.text = subwayStationName;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.filterStations.count) {
        return @"搜索结果";
    }
    NSString *key = [self.keysIndex objectAtIndex:section];
    return key;
}

#pragma mark - UITableViewDelegate -

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keysIndex;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate) {
        NSString *stationName;
        if (self.filterStations.count) {
            stationName = [self.filterStations objectAtIndex:indexPath.row];
        } else {
            NSString *key = [self.keysIndex objectAtIndex:indexPath.section];
            stationName = [[self.subwayInfo arrayValueForKey:key] objectAtIndex:indexPath.row];
        }
        [self.delegate DPSubwayPickerController:self didSelectedSubwayStation:stationName];
    }
    self.searchController.active = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private -

- (void)setupConstraints
{    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

#pragma mark - getter && setter -

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexColor = [UIColor dp_grayColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.tableHeaderView = self.searchController.searchBar;
    }
    return _tableView;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
        _searchController.searchBar.placeholder = @"请输入地铁站点";
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.backgroundColor = [UIColor dp_aLittleGrayColor];
    }
    return _searchController;
}

- (NSDictionary *)subwayInfo
{
    if (!_subwayInfo) {
        _subwayInfo = @{@"a": @[@"安亭", @"鞍山新村", @"爱国路"],
                        @"b": @[@"宝安公路", @"北新泾", @"北桥", @"宝山路", @"博兴路", @"白银路", @"宝杨路", @"北洋泾路"] ,
                        @"c": @[@"漕河泾开发区", @"曹杨路", @"漕宝路", @"成山路", @"赤峰路", @"川沙", @"常熟路", @"场中路", @"昌平路", @"漕溪路", @"春申路", @"昌吉东路", @"创新中路"] ,
                        @"d": @[@"东川路", @"东昌路", @"大连路", @"大华三路", @"东宝兴路", @"大柏树", @"打浦桥", @"大渡河路", @"大世界", @"滴水湖", @"洞泾", @"东明路", @"大木桥路 ", @"东靖路", @"东安路", @"德平路", @"东陆路", @"大场镇", @"东方体育中心"] ,
                        @"f": @[@"富锦路", @"芳华路", @"枫桥路", @"丰庄", @"复兴岛"] ,
                        @"g": @[@"共康路", @"共富新村", @"桂林路", @"广兰路", @"顾村公园", @"国权路", @"高青路", @"高科西路", @"国际客运中心", @"光明路", @"港城路"] ,
                        @"h": @[@"虹桥火车站", @"黄陂南路", @"呼兰路", @"合川路", @"虹桥2号航站楼", @"虹口足球场", @"华宁路", @"汉中路", @"虹桥路", @"花木路", @"虹桥1号航站楼", @"黄兴路", @"惠南", @"航中路", @"海伦路", @"衡山路", @"华夏东路", @"花桥", @"华夏西路", @"黄兴公园", @"航津路", @"海天三路", @"鹤沙航城", @"后滩", @"航头东", @"惠南东", @"华夏中路"] ,
                        @"j": @[@"九亭", @"静安寺", @"金平路", @"江湾镇", @"金运路", @"锦江乐园", @"金科路", @"江苏路", @"嘉定北", @"交通大学", @"剑川路", @"金沙江路", @"江湾体育场", @"江浦路", @"江杨北路", @"锦绣路", @"嘉定新城", @"嘉定西", @"嘉善路", @"江月路", @"金海路", @"金桥路", @"巨峰路", @"江浦公园", @"金京路", @"金沙江西路"] ,
                        @"l": @[@"陆家嘴", @"莲花路", @"娄山关路", @"龙阳路", @"临平路", @"陆家浜路", @"龙柏新村", @"老西门", @"龙溪路", @"龙漕路", @"蓝村路", @"芦恒路", @"李子园路", @"鲁班路", @"岚皋路", @"隆昌路", @"凌兆新村", @"刘行", @"龙华中路", @"灵岩南路", @"联航路", @"临沂新村", @"隆德路", @"临港大道", @"罗山路", @"罗南新村", @"凌空路", @"龙华", @"龙耀路"] ,
                        @"m": @[@"闵行开发区", @"美兰湖", @"马当路", @"马陆", @"民生路"] ,
                        @"n": @[@"南京西路", @"南京东路", @"南翔", @"嫩江路", @"南浦大桥", @"宁国路", @"南陈路"] ,
                        @"p": @[@"彭浦新村", @"浦电路", @"浦东大道", @"浦东国际机场", @"浦江镇", @"浦三路", @"潘广路"] ,
                        @"q": @[@"七宝", @"曲阳路", @"祁连山路", @"祁连山南路", @"曲阜路", @"祁华路"] ,
                        @"r": @[@"人民广场"] ,
                        @"s": @[@"莘庄", @"上海火车站", @"陕西南路", @"淞虹路", @"上海马戏城", @"泗泾", @"佘山", @"世纪公园", @"松江大学城", @"世纪大道", @"沈杜公路", @"四川北路", @"上海南站", @"上海大学站", @"上海体育馆", @"市光路", @"上海科技馆", @"宋园路", @"水城路", @"商城路", @"松江体育中心", @"松江新城", @"上海动物园", @"石龙路", @"上海体育场", @"四平路", @"淞浜路", @"上海赛车场", @"上南路", @"上海西站", @"三林", @"上海图书馆", @"水产路", @"上海游泳馆", @"松江南站", @"三林东", @"上海儿童医学中心", @"上大路", @"淞发路", @"书院", @"三门路", @"上海汽车城", @"申江路", @"上海野生动物园"] ,
                        @"t": @[@"通河新村", @"天潼路", @"唐镇", @"同济大学", @"桃浦新村", @"塘桥", @"铁力路", @"提篮桥"] ,
                        @"w": @[@"汶水路", @"威宁路", @"外环路", @"五角场", @"文井路", @"武宁路", @"五莲路", @"外高桥保税区北", @"外高桥保税区南", @"五洲大道", @"武威路"] ,
                        @"x": @[@"徐家汇", @"徐泾东", @"西藏北路", @"西藏南路", @"新村路", @"新天地", @"行知路", @"新闸路", @"小南门", @"翔殷路", @"星中路", @"新江湾城", @"新场"] ,
                        @"y": @[@"延长路", @"豫园", @"延安西路", @"宜山路", @"伊犁路", @"杨树浦路", @"杨高中路", @"杨思", @"殷高西路", @"延吉中路", @"耀华路", @"友谊西路", @"银都路", @"邮电新村", @"杨高南路", @"友谊路", @"云台路", @"云山路", @"杨高北路", @"御桥", @"源深体育中心", @"远东大道", @"殷高东路", @"云锦路"] ,
                        @"z": @[@"中山公园", @"真北路", @"颛桥", @"张江高科", @"中山北路", @"镇坪路", @"长寿路", @"长江南路", @"中潭路", @"中兴路", @"肇嘉浜路", @"中春路", @"长清路", @"周浦东", @"醉白池", @"兆丰路", @"真如", @"紫藤路", @"中华艺术宫", @"洲海路", @"张华浜"]};
    }
    return _subwayInfo;
}

- (NSMutableArray *)allStations
{
    if (!_allStations) {
        _allStations = [[NSMutableArray alloc] init];
        for (NSString *key in self.keysIndex) {
            _allStations = [[NSMutableArray alloc] initWithArray:[_allStations arrayByAddingObjectsFromArray:[self.subwayInfo arrayValueForKey:key]]];
        }
    }
    return _allStations;
}

- (NSMutableArray *)filterStations
{
    if (!_filterStations) {
        _filterStations = [[NSMutableArray alloc] init];
    }
    return _filterStations;
}

- (NSArray *)keysIndex
{
    if (!_keysIndex) {
        NSArray *keys = self.subwayInfo.allKeys;
        _keysIndex = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return (int)obj1 > (int)obj2;
        }];
    }
    return _keysIndex;
}

@end
