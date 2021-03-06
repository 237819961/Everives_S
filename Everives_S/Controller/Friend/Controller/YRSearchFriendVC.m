//
//  YRSearchFriendVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSearchFriendVC.h"
#import "RequestData.h"
#import "YRUserStatus.h"
#import <UIImageView+WebCache.h>
#import "YRSearchFriendCell.h"
#import "YRUserDetailController.h"
#import "YRSearchBar.h"
static NSString *cellID = @"cellID";
@interface YRSearchFriendVC ()<UISearchBarDelegate>{
    NSArray *_searchRes;
}
@property(nonatomic,strong)YRSearchBar *searchBar;
@property(nonatomic,strong) UIView *tableH;
@end

@implementation YRSearchFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 60;
    self.tableView.tableHeaderView = self.tableH;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"YRSearchFriendCell" bundle:nil] forCellReuseIdentifier:cellID];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchRes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YRSearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell configureCellWithAvatar:[_searchRes[indexPath.row] avatar] name:[_searchRes[indexPath.row] name]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YRUserDetailController *userDetailVC = [[YRUserDetailController alloc] init];
    userDetailVC.userID = [_searchRes[indexPath.row] id];
    [self.navigationController pushViewController:userDetailVC animated:YES];
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSString *searchStr = [_searchBar.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (searchStr.length == 0) {
        return;
    }
    [RequestData GET:[NSString stringWithFormat:@"%@%@",STUDENT_SEARCH_USER,[searchStr  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:@{@"relation":@"1"} complete:^(NSDictionary *responseDic) {
        _searchRes = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
        if (_searchRes.count == 0) {
            [MBProgressHUD showSuccess:@"没有找到符合条件的用户~" toView:self.view];
        }else{
            [self.tableView reloadData];
        }
    } failed:^(NSError *error) {
    }];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSString *searchStr = [_searchBar.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (searchStr.length != 0) {
        return;
    }
    searchBar.text = @"    ";
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if ([searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        searchBar.text = @"";
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *searchStr = [_searchBar.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (searchStr.length == 0) {
        searchBar.text = @"    ";
    }
}

#pragma mark - Getters
-(YRSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[YRSearchBar alloc] initWithFrame:CGRectMake(16, 8, kScreenWidth-32, 44)];
        _searchBar.searchBar.delegate = self;
        _searchBar.searchBar.placeholder = @"请输入驾友用户名或手机号码";
    }
    return _searchBar;
}
-(UIView *)tableH{
    if (!_tableH) {
        _tableH = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        [_tableH addSubview:self.searchBar];
    }
    return _tableH;
}
@end
