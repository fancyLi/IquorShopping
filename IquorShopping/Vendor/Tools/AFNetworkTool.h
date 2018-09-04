//
//  AFNetworkTool.h
//  AFNetText3.x
//
//  Created by 储强盛 on 16/5/01.
//  Copyright © 2016年 Xintech LLC. All rights reserved.
//

/**
 要使用常规的AFN网络访问
 
 1. AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];;
 
 所有的网络请求,均有manager发起
 
 2. 需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
 
 1> 如果提交数据是JSON的,需要将请求格式设置为AFJSONRequestSerializer
 2> 如果返回格式不是JSON的,
 
 3. 请求格式（2.* 版本）
 
 AFHTTPRequestSerializer            二进制格式
 AFJSONRequestSerializer            JSON
 AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
 
 4. 返回格式
 
 AFHTTPResponseSerializer           二进制格式
 AFJSONResponseSerializer           JSON
 AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
 AFXMLDocumentResponseSerializer (Mac OS X)
 AFPropertyListResponseSerializer   PList
 AFImageResponseSerializer          Image
 AFCompoundResponseSerializer       组合
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetworkTool : NSObject

+ (AFURLSessionManager*)urlSessionManager;

+ (AFHTTPSessionManager*)httpSessionManager;

/**检测网路状态**/
+ (void)netWorkStatus:(void (^)(AFNetworkReachabilityStatus netstatus))netstatus;

/**
 *  json获取数据
 *
 *  @param url        地址
 *  @param parameDic  参数
 *  @param messageStr 菊花显示的文字
 *  @param view       菊花显示的view，如果为空就不显示
 *  @param success    返回的成功
 *  @param fail
 *
 *  @return AFHTTPRequestOperation
 */



/**
 *  生成UUID 全球唯一标识
 *
 *  @return uuid
 */
+(NSString*)getStringWithUUID;

//+ (NSURLSessionDataTask *)JSONDataWithUrl:(NSString *)url parame:(NSMutableDictionary *)parameDic showMessag:(NSString *)messageStr toView:(UIView *)view success:(void (^)(id json))success fail:(void (^)())fail;
/**
 *  不需要显示菊花效果（HUD）的json请求
 *
 *  @param url       URL
 *  @param parameDic 参数
 *  @param success   成功
 *  @param fail      失败
 *
 *  @return AFHTTPRequestOperation
 */


+ (NSURLSessionDataTask *)JSONDataWithUrl:(NSString *)url parame:(NSMutableDictionary *)parameDic success:(void (^)(id json))success fail:(void (^)())fail;



/**
  post方式上传图片

 @param url 上传图片的服务器地址
 @param params 接口请求参数
 @param image UIImage
 @param success 上传成功返回
 @param fail 上传失败返回
 @return  AFHTTPRequestOperation，可以用于在界面消失的时候进行Cancel操作
 */
+(NSURLSessionDataTask *)postImageWithUrl:(NSString *)url params:(NSDictionary *)params picImage:(UIImage *)image success:(void (^)(id responseObject))success fail:(void (^)())fail;
/**
 *  post方式批量上传图片
 *
 *  @param url           上传图片的服务器地址
 *  @param params        接口请求参数
 *  @param imageArry     装有 UIImage 的图片数组
 *  @param fileParemsName 图片名称 images[]
 *  @param success       上传成功返回
 *  @param fail          上传失败返回
 *
 *  @return AFHTTPRequestOperation，可以用于在界面消失的时候进行Cancel操作
 */
+(NSURLSessionDataTask *)requestWithUrl:(NSString *)url params:(NSDictionary *)params picImageArray:(NSArray *)imageArry fileName:(NSString *)fileParemsName success:(void (^)(id responseObject))success fail:(void (^)())fail;


/**
 *  AFNetworking 3 批量上传图片
 *
 *  @param url           上传图片的服务器地址
 *  @param params        接口请求参数
 *  @param imageArry     装有 UIImage 的图片数组
 *  @param fileNameArray 图片名称数组
 *  @param success       上传成功返回结果数组
 */
+(void)UploadImageWithUrl:(NSString *)url params:(NSDictionary *)params picImageArray:(NSArray *)imageArry fileName:(NSArray *)fileNameArray success:(void (^)(id responseObject))success;



/**
 *  PUT 原生批量上传图片
 *
 *  @param url              host 后面自动拼接uuid为文件后缀
 *  @param imageArry        图片数组
 *  @param success          成功的url数组
 *  @param fail             失败的图片标记数组
 */
+(void)uploadPutImageWithUrl:(NSString*)url picImageArray:(NSArray *)imageArry success:(void (^)(id responseObject))success fail:(void (^)(id failResult))fail;


/**
 *  PUT上传单个文件
 *
 *  @param url     完整url
 *  @param data    文件流
 *  @param success 成功及返回
 *  @param fail    失败及返回
 */
+(void)uploadPutFileWithUrl:(NSString*)url withData:(id)data success:(void (^)(id responseObject))success fail:(void (^)())fail;

/**
 *xml方式获取数据
 *urlStr:获取数据的url地址
 *
 */
+ (void)XMLDataWithUrl:(NSString *)urlStr success:(void (^)(id xml))success fail:(void (^)())fail;

/**
 *JSON方式post提交数据
 *urlStr:服务器地址
 *parameters:提交的内容参数
 *
 */
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;


/**
 *  JSON方式get提交数据
 *
 *  @param urlStr     服务器地址
 *  @param parameters 提交的内容参数
 */
+ (void)getJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;

/**
 *Session下载文件
 *urlStr :   下载文件的url地址
 *
 */
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail;

/**
 *文件上传,自己定义文件名
 *urlStr:    需要上传的服务器url
 *fileURL:   需要上传的本地文件URL
 *fileName:  文件在服务器上以什么名字保存
 *fileTye:   文件类型
 *
 */
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id responseObject))success fail:(void (^)())fail;

/**
 *文件上传,文件名由服务器端决定
 *urlStr:    需要上传的服务器url
 *fileURL:   需要上传的本地文件URL
 *
 */
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)())fail;
@end
