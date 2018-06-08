//
//  HttpConstant.h
//  PasswordDeblocking
//
//  Created by goodjobs-mac on 2016/11/23.
//  Copyright © 2016年 mi-pass. All rights reserved.
//

#ifndef HttpConstant_h
#define HttpConstant_h

#define HostUrl                     @"http://chengchuan.ahaiba.com.cn/"
#define BaseURL                 [NSString stringWithFormat:@"%@index.php/",HostUrl]


/********  个人中心  ******************/
//获取验证码 获取类型(1.注册2.重置密码)
#define me_getSMS_url                 @"user/getVerifyingCode"

//注册第一步
#define me_registone_url                 @"user/userReg"



//普通登录
#define me_login_url                  @"user/userLogin"


//更改昵称
#define update_nikename_url                 @"user/modifyTheNickname"

//更改头像
#define update_userAvatar_url                  @"user/uploadAvatar"

#pragma mark 地址列表
//获取省市区
#define get_regionlist_url                  @"user/regionJaonData"

//新增地址
#define save_address_url                        @"user/addAddr"

//编辑地址
#define user_editAddr_url                       @"user/editAddr"

//获取地址列表
#define user_addrList_url                       @"user/addrList"

//优惠券列表
#define user_couponList_url                        @"user/couponList"

//修改密码
#define me_changePassword_url               @"user/modifyThePassword"

//重置密码
#define me_resetPassword_url                 @"user/resetPassword"

//提交留言
#define msg_upload_url                       @"user/onlineMessage"



#endif /* HttpConstant_h */
