//
//  JoinsViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "JoinsViewController.h"
#import "JoinModel.h"
@interface JoinsViewController ()<UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) JoinModel *join;
@end

@implementation JoinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加盟";
    [self requestJoin];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.tableHeaderView = self.imageview;
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.rowHeight = 45;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)requestJoin {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:join_Advantage_url parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.join = [JoinModel yy_modelWithJSON:responseObject[@"content"]];
            [self.imageview sd_setImageWithURL:[NSURL URLWithString:self.join.join_pic] placeholderImage:[UIImage imageNamed:@"icon_35"]];
            [self.tableview reloadData];
            [self.webview loadHTMLString:self.join.advantage baseURL:nil];
            
        }else {
        }
    } fail:^{
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (indexPath.row == 0) {
        NSString *str = [NSString stringWithFormat:@"加盟费用：￥%@", self.join.join_money];
        NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:str];
        [mutStr setAttributes:@{NSForegroundColorAttributeName:[UIColor c_333Color], NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, 5)];
        [mutStr setAttributes:@{NSForegroundColorAttributeName:[UIColor c_cc0Color], NSFontAttributeName: [UIFont systemFontOfSize:24]} range:NSMakeRange(5, str.length-5)];
        cell.textLabel.attributedText = mutStr;
    }else {
        cell.textLabel.text = @"经销商权益";
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    return cell;
}
- (IBAction)startJoin:(UIButton *)sender {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), webViewHeight);
    [self.tableview beginUpdates];
    [self.tableview setTableFooterView:self.webview];
    [self.tableview endUpdates];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImageView *)imageview {
    if (!_imageview) {
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    }
    return _imageview;
}
- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        _webview.backgroundColor = [UIColor whiteColor];
        _webview.scrollView.bounces = NO;
        _webview.delegate = self;
        _webview.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webview;
}

@end
