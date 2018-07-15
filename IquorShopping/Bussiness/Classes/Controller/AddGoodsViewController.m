//
//  AddGoodsViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AddGoodsViewController.h"
#import "UIControl+IquorArea.h"
@interface AddGoodsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UIButton *operateBtn;

@end

@implementation AddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    [self.closeBtn setEnlargeEdge:20];
    [self.leftBtn setBackgroundColor:[UIColor c_fbfbfbColor]];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:0 bottom:10 left:10];
    [self.rightBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:0];
    
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closePageVC)];
    [self.view addGestureRecognizer:closeTap];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.goodsInfo.goods_image] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    self.name.text = self.goodsInfo.goods_name;
    self.price.text = [NSString stringWithFormat:@"￥%@", self.goodsInfo.goods_price];
    if (self.isCart) {
        [self.operateBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
}

- (void)closePageVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startBuy:(id)sender {
    @weakify(self);
    if (self.isCart) {
        NSDictionary *param = @{
                                @"goods_id":self.goodsInfo.goods_id,
                                @"goods_num": self.num.text
                                };
        //事件类型(1.取消收藏2.新增收藏)
        [AFNetworkTool postJSONWithUrl:shop_addToCart parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            [Dialog popTextAnimation:responseObject[@"message"]];
            if (code == 200) {
                [self closePageVC];
            }
        } fail:^{
            
        }];
    }else {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.operatorBuyBlock) {
                self.operatorBuyBlock();
            }
        }];
        
    }
    
}

- (IBAction)closePage:(id)sender {
    [self closePageVC];
}
- (IBAction)addButton:(UIButton *)sender {
    int num = self.num.text.intValue;
    num++;
    if (num>1) {
        self.leftBtn.enabled = YES;
        [self.leftBtn setBackgroundColor:[UIColor c_f5f5f5Color]];
    }
    self.num.text = [NSString stringWithFormat:@"%i", num];
}
- (IBAction)reduceButton:(UIButton *)sender {
    int num = self.num.text.intValue;
    num--;
    self.num.text = [NSString stringWithFormat:@"%i", num];
    if (num <= 1) {
        sender.enabled = NO;
        [self.leftBtn setBackgroundColor:[UIColor c_fbfbfbColor]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
