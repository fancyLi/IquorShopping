//
//  MeConfigModel.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/14.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeConfigModel.h"
#import "IndentViewController.h"
#import "MeCollectViewController.h"
#import "DiscountViewController.h"
#import "TeamsViewController.h"
#import "BrokerViewController.h"
#import "JoinsViewController.h"
#import "StartViewController.h"
#import "AddressViewController.h"
@implementation MeConfigModel

- (instancetype)initIconName:(NSString *)ic dec:(NSString *)dec cla:(NSString *)cla need:(BOOL)need {
    self = [super init];
    if (self) {
        self.iconName = ic;
        self.dec = dec;
        self.className = cla;
        self.need = need;
    }
    return self;
}
- (NSArray *)configModels {
        NSArray *ar1 = @[
                        [[MeConfigModel alloc]initIconName:@"icon_my_01" dec:@"待付款" cla:@"IndentViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_02" dec:@"待发货" cla:@"IndentViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_03" dec:@"待收货" cla:@"IndentViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_04" dec:@"待评价" cla:@"IndentViewController" need:YES]
                        ];
        NSArray *ar2 = @[
                         [[MeConfigModel alloc]initIconName:@"icon_my_05" dec:@"我的团队" cla:@"TeamsViewController" need:YES],
                         [[MeConfigModel alloc]initIconName:@"icon_my_06" dec:@"我的佣金" cla:@"BrokerViewController" need:YES],
                         [[MeConfigModel alloc]initIconName:@"icon_my_07" dec:@"我的分红" cla:@"BrokerViewController" need:YES],
                         [[MeConfigModel alloc]initIconName:@"" dec:@"" cla:@"" need:NO]
                         ];
       NSArray *ar3 = @[
                        [[MeConfigModel alloc]initIconName:@"icon_my_08" dec:@"我的余额" cla:@"BaoViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_09" dec:@"我的优惠券" cla:@"DiscountViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_10" dec:@"我的收藏" cla:@"MeCollectViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_11" dec:@"我的评价" cla:@"CommentViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_12-1" dec:@"我的地址" cla:@"AdressListViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_13-1" dec:@"修改密码" cla:@"ChangePasswordViewController" need:YES],
                        [[MeConfigModel alloc]initIconName:@"icon_my_12" dec:@"关于我们" cla:@"AboutViewController" need:NO],
                        [[MeConfigModel alloc]initIconName:@"icon_my_13" dec:@"设置" cla:@"SetViewController" need:NO],
                        [[MeConfigModel alloc]initIconName:@"icon_my_14" dec:@"联系客服" cla:@"9" need:NO],
                        [[MeConfigModel alloc]initIconName:@"icon_my_15" dec:@"在线留言" cla:@"MsgViewController" need:NO],
                        [[MeConfigModel alloc]initIconName:@"" dec:@"" cla:@"" need:NO],
                        [[MeConfigModel alloc]initIconName:@"" dec:@"" cla:@"" need:NO]
                        ];

        NSArray *ar4 = @[ar1, ar2, ar3];
        return ar4;
}
@end
