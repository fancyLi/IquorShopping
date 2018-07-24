//
//  GoodsDetailViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "AddGoodsViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "IndentDetailViewController.h"
#import "DetailTableHeader.h"
#import "DetailPageFooter.h"
#import "MeSectionTableView.h"
#import "GoodsInfoModel.h"
#import "AssessCell.h"
@interface GoodsDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DetailTableHeader *tableHead;
@property (nonatomic, strong) DetailPageFooter *pageFooter;
@property (nonatomic, strong) GoodsInfoModel *goodsDetail;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, copy) NSString *isCollected;
@property (nonatomic, assign) BOOL isCart;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestGoodsInfo];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.pageFooter];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
    }];
    [self.pageFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)requestGoodsInfo {
    @weakify(self);
    NSDictionary *param = @{
                            @"goods_id":self.goods_id
                            };
    [AFNetworkTool postJSONWithUrl:goods_detail_url parameters:param success:^(id responseObject) {
        
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];        
        if (code == 200) {
            GoodsInfoModel *model = [GoodsInfoModel yy_modelWithDictionary:responseObject[@"content"]];
            self.tableHead.goodsInfo = model;
            [self loadFrament:model.goods_detail];
            self.goodsDetail = model;
            self.isCollected = model.isCollect;
            self.pageFooter.isCol = model.isCollect.intValue==1?YES:NO;
            self.goods_detail = model.goods_detail;
            [self.tableView reloadData];
        }else {
            
        }
        
    } fail:^{
        
    }];
}
- (void)contactServer {
    NSString *telNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"severTel"];
    if ([UIUtils isNullOrEmpty:telNum]) {
        telNum = @"400-0551-888";
    }
    NSString *tel = [NSString stringWithFormat:@"tel:%@", telNum];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:tel]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    }
}
- (void)collectGooods {
    NSDictionary *param = @{
                            @"goods_id":self.goods_id,
                            @"collect_type": self.isCollected
                            };
    //事件类型(1.取消收藏2.新增收藏)
    [AFNetworkTool postJSONWithUrl:shop_addOrDelGoodsCollection parameters:param success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
           ;
            [Dialog popTextAnimation:[self.isCollected isEqualToString:@"1"]?@"已取消收藏":@"收藏成功"];
            self.pageFooter.isCol = self.isCollected.intValue == 1 ?NO:YES;
            self.isCollected = [self.isCollected isEqualToString:@"1"]?@"2":@"1";
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }

    } fail:^{
        
    }];
}
- (void)skipGoodsCart {
    self.tabBarController.selectedIndex = 3;
}
- (void)showAddPage {
    if ([UIUtils isNullOrEmpty:[IQourUser shareInstance].user_tel]) {
        [[LoginOperator shareInstance] alertLogin];
    }else {
        AddGoodsViewController *vc = [[AddGoodsViewController alloc]init];
        vc.goodsInfo = self.goodsDetail;
        vc.isCart = self.isCart;
        @weakify(self);
        vc.operatorBuyBlock = ^(NSString *goods_id, NSString *goods_num) {
            @strongify(self);
            //立即购买
            IndentDetailViewController *vc = [[IndentDetailViewController alloc]init];
            vc.goods_ids_nums = [NSString stringWithFormat:@"%@#%@", goods_id, goods_num];
            vc.pay_scene = @"4";
            vc.order_type = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }else{
            vc.modalPresentationStyle=UIModalPresentationCurrentContext;
        }
        [self presentViewController:vc animated:YES completion:nil];
    }
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.goodsDetail.comment_info.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if (self.goodsDetail.comment_info.count) {
            return 50;
        }
        return 0.1;
    }
    return 50;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([AssessCell class]) cacheByIndexPath:indexPath configuration:^(AssessCell *cell) {
        [cell configCell:self.goodsDetail.comment_info[indexPath.row]];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.goodsDetail.comment_info.count && section == 0) {
        MeSectionTableView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeSectionTableView" owner:self options:nil] firstObject];
        headerView.leftTitle = @"用户评价";
        headerView.rightTitle = @"查看所有评价";
        headerView.tableSectionOperatorBlock = ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"currentViewControllerChangged" object:nil];
        };
        return headerView;
    }else if (section == 1) {
        MeSectionTableView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeSectionTableView" owner:self options:nil] firstObject];
        headerView.leftTitle = @"商品详情";
        return headerView;
    }
    return nil;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssessCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AssessCell class])];
    [cell configCell:self.goodsDetail.comment_info[indexPath.row]];
    return cell;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), webViewHeight);
    [self.tableView beginUpdates];
    [self.tableView setTableFooterView:self.webview];
    [self.tableView endUpdates];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"currentViewControllerChangged" object:nil];
}
- (void)loadFrament:(NSString *)frament {
    NSString *HTML = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:15px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       "$img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",frament];
    [self.webview loadHTMLString:HTML baseURL:nil];
}
#pragma mark set & get
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"AssessCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AssessCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 50;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.tableHead;
//        _tableView.tableFooterView = self.tableFooter;
        
    }
    return _tableView;
}
- (DetailTableHeader *)tableHead {
    if (!_tableHead) {
        _tableHead = [[NSBundle mainBundle] loadNibNamed:@"DetailTableHeader" owner:self options:nil].firstObject;
        _tableHead.frame = CGRectMake(0, 0, kMainScreenWidth, 0);
    }
    return _tableHead;
}


- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _webview.delegate = self;
    }
    return _webview;
}

- (DetailPageFooter *)pageFooter {
    if (!_pageFooter) {
        _pageFooter = [[NSBundle mainBundle] loadNibNamed:@"DetailPageFooter" owner:self options:nil].firstObject;
        @weakify(self);
        _pageFooter.buttonClickBlock = ^(NSInteger index) {
            @strongify(self);
            switch (index) {
                case 0:
                    [self contactServer];
                    break;
                case 1:
                    [self collectGooods];
                    break;
                case 2:
                    [self skipGoodsCart];
                    break;
                case 3:
                {
                    self.isCart = YES;
                    [self showAddPage];
                }
                    break;
                case 4:
                {
                    self.isCart = NO;
                    [self showAddPage];
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _pageFooter;
}
@end
