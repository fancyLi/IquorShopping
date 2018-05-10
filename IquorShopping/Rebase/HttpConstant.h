//
//  HttpConstant.h
//  PasswordDeblocking
//
//  Created by goodjobs-mac on 2016/11/23.
//  Copyright © 2016年 mi-pass. All rights reserved.
//

#ifndef HttpConstant_h
#define HttpConstant_h

#define HostUrl                     @"http://shangshangmi.ahaiba.com.cn/"
#define BaseURL                 [NSString stringWithFormat:@"%@index.php/",HostUrl]

/********  Base  ******************/
//公告详情
#define Home_NoticeContent_Url               @"base/noticeContent"
//平台列表
#define Home_PlatformList_Url               @"base/platformList"
//任务大厅列表
#define Home_TaskList_Url               @"base/taskList"
//版本检测
#define Home_CheckVersion_Url           @"base/checkVersion"
//用户协议
#define Home_Agreement_Url            @"base/agreement"
//站点基础配置。包含佣金分配比例
#define Home_BaseConfig_Url  @"base/baseConfig"
/********  刷手  ******************/

//  base/homePage
//首页数据
#define Home_Brush_Url               @"base/homePage"

//投诉商家
#define Brush_Complain_Url           @"brush/complain"

//投诉刷手
#define Shop_Complain_Url           @"shop/complain"

//刷手领取任务
#define Home_BrushrecieveTask_Url           @"brush/recieveTask"

//投诉记录
//刷手
#define Home_BrushcomplainList_Url          @"brush/complainList"
//商家
#define Home_ShopcomplainList_Url          @"shop/complainList"

//*任务详情*/
//待提交
#define Brush_TaskInfoWaitSubmit_Url        @"brush/taskInfoWaitSubmit"
//进行中
#define Brush_TaskInfo_Url                  @"brush/taskInfo"

//确认收货（并评价）
#define Brush_TaskInfoConfirm_Url        @"brush/confirmTask"

//提交订单
#define Brush_CommitTask_Url        @"brush/commitTask"

//评价任务
#define Brush_CommentTask_Url           @"brush/commentTask"


/********  商家  ******************/
//任务详情
#define Shop_TaskInfo_Url       @"shop/taskInfo"
//驳回申请
#define Shop_TaskRefuse_Url     @"shop/refuseTask"
//关闭申请
#define Shop_TaskClose_Url     @"shop/closeTask"
//确认 任务
#define Shop_TaskConfirmApply_Url      @"shop/confirmTaskApply"
//确认发货
#define Shop_TaskDeliver_Url   @"shop/taskDeliver"
//再来一单
#define Shop_TaskAdd_Url    @"shop/addTask"
//我的发布
#define Shop_TaskHistoryList_Url    @"shop/historyTaskList"

/********  个人中心  ******************/
//获取验证码
#define me_getSMS_url                 @"login/getSmsCode"

//注册第一步
#define me_registone_url                 @"login/registerStepOne"

//注册第二步
#define me_registwo_url                 @"login/registerStepTwo"

//普通登录
#define me_login_url                  @"login/login"

//其他登录
#define me_otherlogin_url                 @"login/otherLogin"

//获取用户信息
#define me_brush_userInfo                   @"brush/userInfo"
//获取商家用户信息
#define me_agent_userInfo                   @"agent/userInfo"
#define me_business_userInfo                @"shop/userInfo"

//用户个人中心
#define brush_center_userInfo                  @"brush/brushCenter"
#define agent_center_userInfo                  @"agent/agentCenter"
#define business_center_userInfo               @"shop/shopCenter"

//更改用户信息
#define update_brush_userInfo               @"brush/userEdit"
#define update_agent_userInfo               @"agent/userEdit"
#define update_business_userInfo            @"shop/userEdit"

//用户余额
#define brush_Yue_money                     @"brush/money"
#define agent_Yue_money                     @"agent/money"
#define business_Yue_money                  @"shop/money"


//绑定手机号
#define me_bindMobile_url                 @"login/bindMobile"

//完善用户信息
#define me_completeInfo_url                 @"login/completeInfo"

//修改刷手密码
#define modify_brush_password                 @"brush/passwordModify"

//修改代理密码
#define modify_agent_password                 @"agent/passwordModify"

//修改商家密码
#define modify_business_password                 @"shop/passwordModify"

//重置密码
#define me_resetPassword_url                 @"login/resetPassword"

//刷手签到
#define brush_sign_url                       @"brush/sign"

//刷手经验值
#define brush_expValue_Url                   @"brush/expLog"

//佣金明细
#define brush_commission_url                @"brush/commissionList"
#define agent_commission_url                @"agent/commissionList"
#define business_commission_url              @"shop/commissionList"

//分销中心
#define brush_distributeCenter_url           @"brush/distributionCenter"
#define agent_distributeCenter_url           @"agent/distributionCenter"
#define brusines_distributeCenter_url        @"shop/distributionCenter"

//分销中心佣金
#define brush_disCommission_url              @"brush/distributeMoney"
#define agent_disCommission_url              @"agent/distributeMoney"
#define brusines_disCommission_url           @"shop/distributionMoney"

//提现记录
#define brush_drawRecode_url                @"brush/txList"
#define agent_drawRecode_url                @"agent/txList"
#define business_drawRecode_url             @"shop/txList"


//任务列表
#define brush_taskInfo_list_Url              @"brush/brushTaskList"
#define business_taskInfo_list_Url           @"shop/shopTaskList"

//获取代理下的刷手
#define get_agent_brush_url                 @"agent/brushList"

//获取的下线
#define get_brush_brush_url                 @"brush/recommendList"
#define get_business_brush_url              @"shop/recommendList"


//刷手提交给下线提交审核
#define submit_brush_appoint                 @"brush/recommendApply"

//刷手申请代理
#define brush_apply_agent                   @"brush/agentApply"

//代理分配验证码
#define agent_engender_code                 @"agent/createAgentnum"
//验证码列表
#define agent_engender_codeList             @"agent/agentnumList"

//代理查看申请
#define agent_scan_apply                    @"agent/brushApply"

//代理处理申请
#define agent_handle_apply                  @"agent/dealApply"

//余额查询
#define get_brush_blance                    @"brush/money"
#define get_agent_blance                    @"agent/money"
#define get_busines_blance                   @"shop/money"

//申请提现
#define apply_brush_money                   @"brush/txApply"
#define apply_agent_money                   @"agent/txApply"
#define apply_busines_money                 @"shop/txApply"

//修改银行卡信息
#define update_brush_bankCard              @"brush/bankcardModify"
#define update_agent_bankCard              @"agent/bankcardModify"
#define update_busines_bankCard            @"shop/bankcardModify"

//修改支付宝信息
#define updae_brush_baoCard                 @"brush/alipayModify"
#define update_agent_baoCard                @"agent/alipayModify"
#define update_busines_baoCard              @"shop/alipayModify"

//获取银行卡信息
#define get_base_bankInfo_Url               @"base/bankList"


#endif /* HttpConstant_h */
