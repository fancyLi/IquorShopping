//
//  HttpConstant.h
//  PasswordDeblocking
//
//  Created by goodjobs-mac on 2016/11/23.
//  Copyright © 2016年 mi-pass. All rights reserved.
//

#ifndef HttpConstant_h
#define HttpConstant_h

#define HostUrl                     @"http://www.zuixiaoyaojiuye.com/"
#define BaseURL                 [NSString stringWithFormat:@"%@index.php/",HostUrl]


/********  个人中心  ******************/
//获取验证码 获取类型(1.注册2.重置密码)
#define me_getSMS_url                 @"user/getVerifyingCode"

//注册第一步
#define me_registone_url                 @"user/userReg"



//普通登录
#define me_login_url                  @"user/userLogin"

#define get_user_info_url             @"user/personalData"

//会员升级
#define user_upGrade                    @"user/upGrade"

//更改昵称
#define update_nikename_url                 @"user/modifyTheNickname"

//个人中心-我的
#define user_personCenter                      @"user/personCenter"
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
//修改地址
#define user_addressInfo                        @"user/addressInfo"
//删除地址
#define user_addrDelete                         @"user/addrDelete"
//优惠券列表
#define user_couponList_url                        @"user/couponList"

//加盟
#define join_Advantage_url                          @"user/joinAdvantage"

//我的佣金
#define person_Commision_url                       @"user/personCommision"
//佣金流水
#define person_CommisionWater_url                       @"user/commisionWater"

//佣金提现
#define user_commisionPutForward                       @"user/commisionPutForward"

//我的分红
#define person_bonus_url                       @"user/personBonus"
//分红流水
#define bonus_Water_url                       @"user/bonusWater"

//余额
#define user_userBalance                   @"user/userBalance"

//余额流水
#define user_balanceWater                   @"user/balanceWater"
//分红提现
#define user_bonusPutForward                    @"user/bonusPutForward"

//提现前获取信息
#define user_theBalanceIsBefore             @"user/theBalanceIsBefore"

//余额提现
#define user_balancePutForward              @"user/balancePutForward"

//修改密码
#define me_changePassword_url               @"user/modifyThePassword"

//重置密码
#define me_resetPassword_url                 @"user/resetPassword"

//提交留言
#define msg_upload_url                       @"user/onlineMessage"

//填写邀请码
#define user_modifyTheUserCode                @"user/modifyTheUserCode"

//====== 商品管理类 =======
//首页产品
#define index_homePage                          @"index/homePage"

//首页优惠券
#define index_aCouponThatCanBeReceived           @"index/aCouponThatCanBeReceived"

//订单优惠券
#define order_getOrderCoupon                     @"order/getOrderCoupon"

//首页优惠券
#define index_receiveCoupon           @"index/receiveCoupon"

//单个商品详情
#define goods_detail_url                          @"shop/goodsInfo"

//单个商品收藏
#define shop_addOrDelGoodsCollection                @"shop/addOrDelGoodsCollection"

//我的收藏
#define user_goodsCollection                        @"user/goodsCollection"

//取消收藏
#define user_delGoodsCollection                      @"user/delGoodsCollection"

//我的评价
#define user_goodsEvaluate                          @"user/goodsEvaluate"

//我的订单
#define user_userOrderList                          @"user/userOrderList"

//订单详情
#define user_orderInfo                              @"user/orderInfo"

//订单处理
#define user_userOrderDeal                          @"user/userOrderDeal"

//产品分类
#define shop_goodsCatList                       @"shop/goodsCatList"

//产品列表
#define shop_goodsList                          @"shop/goodsList"

//单个商品评价
#define shop_goodsComment                       @"shop/goodsComment"

//商品评价上传图片
#define user_uploadCommentFile                  @"user/uploadCommentFile"

//商品评价-提交
#define user_addGoodsComment                    @"user/addGoodsComment"

//加入购物车
#define shop_addToCart                          @"shop/addToCart"

//购物车列表
#define shop_shoppingCart                       @"shop/shoppingCart"

//购物车列表加减
#define shop_changeCartGoodsNum                 @"shop/changeCartGoodsNum"

//删除购物车
#define shop_delCartGoods                       @"shop/delCartGoods"

//新增支付宝
#define user_addOrEditAliPayAccount             @"user/addOrEditAliPayAccount"

//订单详情
#define order_beforeSubOrder                    @"order/beforeSubOrder"
//提交订单
#define pay_requestPayment                      @"pay/requestPayment"

//订单结果页面
#define order_getOrdersnInfo                    @"order/getOrdersnInfo"


//获取银行卡信息
#define user_getAListOfBanks                    @"user/getAListOfBanks"

//获取用户银行开列表
#define user_userBankAccountList                @"user/userBankAccountList"
//新增银行卡
#define user_addBankAccount                     @"user/addBankAccount"

//获取支付方式
#define index_paymentType                       @"index/paymentType"

//关于我们
#define user_aboutUs                            @"user/aboutUs"
#endif /* HttpConstant_h */
