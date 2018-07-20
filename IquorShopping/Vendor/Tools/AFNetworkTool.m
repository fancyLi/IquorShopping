//
//  AFNetworkTool.m
//  AFNetText3.x
//
//  Created by 储强盛 on 16/5/01.
//  Copyright © 2016年 Xintech LLC. All rights reserved.
//

#import "AFNetworkTool.h"
#import "AppDelegate.h"

@implementation AFNetworkTool

static AFHTTPSessionManager* httpSessionManager = nil;
static AFURLSessionManager* urlSessionManager = nil;

+ (AFURLSessionManager*)urlSessionManager
{
    if (!urlSessionManager) {
        urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return urlSessionManager;
}

+ (AFHTTPSessionManager*)httpSessionManager
{
    if (!httpSessionManager) {
        httpSessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BaseURL]];
        httpSessionManager.requestSerializer.HTTPShouldHandleCookies = YES;
       
        
    }
    
    return httpSessionManager;
}


#pragma mark 检测网路状态
+ (void)netWorkStatus:(void (^)(AFNetworkReachabilityStatus netstatus))netstatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld", (long)status);
        netstatus(status);
    }];
}

#pragma mark 生成UUID 全球唯一标识

/**
 *  生成UUID 全球唯一标识
 *
 *  @return uuid
 */
+(NSString*)getStringWithUUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    NSString *uuidString =(NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    uuidString=[NSString stringWithUTF8String:[uuidString cStringUsingEncoding:NSUTF8StringEncoding]];
    CFRelease(uuidObj);
    uuidString= [uuidString lowercaseString];
    return uuidString;
}

#pragma mark - 上传图片 单张
+(NSURLSessionDataTask *)postImageWithUrl:(NSString *)url params:(NSDictionary *)params picImage:(UIImage *)image success:(void (^)(id responseObject))success fail:(void (^)())fail{
    if (url==nil) { //给一个默认的把。。老是写好烦
        [Dialog popTextAnimation:@"不合法的Url"];
        return nil;
    }
    AFHTTPSessionManager *manager = [self httpSessionManager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
     [PDDDataManger loadLoginCookie];
    
    NSURLSessionDataTask*task= [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                
                //               NSString *str = [self getStringWithUUID];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
 
                NSData *iamgeData = UIImageJPEGRepresentation(image, 0.7);
        
                
                [formData appendPartWithFileData:iamgeData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(dataDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
    }];
    
    return task;
}


#pragma mark 批量上传图片
+(NSURLSessionDataTask *)requestWithUrl:(NSString *)url params:(NSDictionary *)params picImageArray:(NSArray *)imageArry fileName:(NSString *)fileParemsName success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    if (url==nil) { //给一个默认的把。。老是写好烦
        [Dialog popTextAnimation:@"不合法的Url"];
        return nil;
    }
    AFHTTPSessionManager *manager = [self httpSessionManager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [PDDDataManger loadLoginCookie];
    
   NSURLSessionDataTask*task= [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       if (imageArry) {
           for (int i=0; i<imageArry.count; i++) {
               //                NSData *picData = UIImageJPEGRepresentation(imageArry[i], 1);
               
               NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
               formatter.dateFormat = @"yyyyMMddHHmmss";
               NSString *str = [formatter stringFromDate:[NSDate date]];
               
//               NSString *str = [self getStringWithUUID];
               NSString *fileName = [NSString stringWithFormat:@"%@%d.png", str,i];
               
            
               
               UIImage *image = imageArry[i];
               NSData *iamgeData = UIImageJPEGRepresentation(image, 0.7);
               
               /* 其他类型
//                [formData appendPartWithFileData:iamgeData name:fileNameArray[i] fileName:fileName mimeType:@"application/octet-stream"];
                [formData appendPartWithFileData:iamgeData name:fileNameArray[i] fileName:fileName mimeType:@"multipart/form-data"];

               */
               
               [formData appendPartWithFileData:iamgeData name:fileParemsName fileName:fileName mimeType:@"image/jpg/png/jpeg"];
  
           }
       }
       
   } progress:^(NSProgress * _Nonnull uploadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
       if (success) {
           NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
           success(dataDic);
       }
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
       NSLog(@"%@", error);
       if (fail) {
           fail();
       }
   }];

    return task;
}


#pragma mark - AFNetworking 3 PUT批量上传图片
+(void)UploadImageWithUrl:(NSString *)url params:(NSDictionary *)params picImageArray:(NSArray *)imageArry fileName:(NSArray *)fileNameArray success:(void (^)(id responseObject))success{
    
    // 准备保存结果的数组，元素个数与上传的图片个数相同，先用 NSNull 占位
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:imageArry.count];
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < imageArry.count; i++) {
        UIImage* image=imageArry[i];
        
        dispatch_group_enter(group);
        
        NSError* error = NULL;
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
          
         //   NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            
//            [formData appendPartWithFileData:imageData name:fileNameArray[i] fileName:str mimeType:@"multipart/form-data"];
            [formData appendPartWithFileData:imageData name:fileNameArray[i] fileName:str mimeType:@"image/jpeg"];
        
        } error:&error];
        
        // 可在此处配置验证信息
        //比如身份验证 NSMutableURLRequest 的header 之类
     

        // 将 NSURLRequest 与 completionBlock 包装为 NSURLSessionUploadTask
        AFURLSessionManager *manager = [self urlSessionManager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        NSURLSessionUploadTask* uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"第 %d 张图片上传失败: %@", (int)i + 1, error);
                dispatch_group_leave(group);
            } else {
                NSLog(@"第 %d 张图片上传成功: %@", (int)i + 1, responseObject);
                @synchronized (result) { // NSMutableArray 是线程不安全的，所以加个同步锁
                    result[i] = responseObject;
                }
                dispatch_group_leave(group);
            }
        }];
        
        [uploadTask resume];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成!");
        for (id response in result) {
            NSLog(@"%@", response);
        }
        //回传结果集
        success(result);
        
    });
}

#pragma mark PUT 原生批量上传图片
+(void)uploadPutImageWithUrl:(NSString*)url picImageArray:(NSArray *)imageArry success:(void (^)(id responseObject))success fail:(void (^)(id failResult))fail{

       __block NSMutableArray* arrayUrl=[NSMutableArray array];
    
    // 准备保存结果的数组，元素个数与上传的图片个数相同，先用 NSNull 占位
   __block NSMutableArray* result = [NSMutableArray array];
    __block  NSMutableArray* failResult = [NSMutableArray array];
    
    for (UIImage* image in imageArry) {
        [result addObject:[NSNull null]];
        [failResult addObject:[NSNull null]];
        //36 位唯一标识符作为图片ID
        NSString*uuid=[self getStringWithUUID];
        //1.创建url
        NSString* urlStr=[NSString stringWithFormat:@"%@%@.jpg",url,uuid];
        [arrayUrl addObject:urlStr];
    }
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < imageArry.count; i++) {
        UIImage* image=imageArry[i];
        
        dispatch_group_enter(group);
        
        NSString* urlStr=arrayUrl[i];
        
        urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *urlimage=[NSURL URLWithString:urlStr];
        //2.创建请求
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlimage];
        request.HTTPMethod=@"PUT";
    
        NSData* dataImage=UIImageJPEGRepresentation(image, 0.3);
        
        request.HTTPBody=dataImage;
        
        [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)dataImage.length] forHTTPHeaderField:@"Content-Length"];
        [request setValue:[NSString stringWithFormat:@"image/jpeg"] forHTTPHeaderField:@"Content-Type"];
        
        //4.创建会话
        NSURLSession *session=[NSURLSession sharedSession];
        NSURLSessionUploadTask *uploadTask=[session uploadTaskWithRequest:request fromData:dataImage completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                
              NSMutableArray *dataArr =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                  NSString *str =[NSString stringWithFormat:@"%@",obj];
                    [dataArr replaceObjectAtIndex:idx withObject:str];
                }];
                NSLog(@"第 %d 张图片上传成功: %@", (int)i + 1, dataArr);
                @synchronized (result) { // NSMutableArray 是线程不安全的，所以加个同步锁
                    [result replaceObjectAtIndex:i withObject:dataArr[1]];
                }
                dispatch_group_leave(group);
          
            }else{
                NSLog(@"第 %d 张图片上传失败: %@", (int)i + 1,error.localizedDescription);
                [failResult addObject:[NSNumber numberWithInt:(int)i + 1]];
                dispatch_group_leave(group);
            }
        }];
        
        [uploadTask resume];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成!");
        success([result mutableCopy]);
        
        if (failResult.count>0) {
             fail(failResult);
        }
    });
}


#pragma mark PUT上传单个文件
+(void)uploadPutFileWithUrl:(NSString*)url withData:(id)data success:(void (^)(id responseObject))success fail:(void (^)())fail{
    //    NSString *fileName=@"test.jpg";
    
    //1.创建url
    NSString* urlStr=[NSString stringWithFormat:@"%@",url];

    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlData=[NSURL URLWithString:urlStr];
    //2.创建请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlData];
    request.HTTPMethod=@"PUT";
    
    //3.构建数据
    

    
    NSData* dataUP=[NSData dataWithData:data];
    
    //    NSString *path=[[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    //    NSData *data=[self getHttpBody:fileName];
    request.HTTPBody=dataUP;
    
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)dataUP.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"application/octet-stream"] forHTTPHeaderField:@"Content-Type"];

    
    
    //4.创建会话
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask=[session uploadTaskWithRequest:request fromData:dataUP completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSString *dataStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"上传完成返回--%@",dataStr);
            success(dataStr);
            
            
        }else{
            NSLog(@"error is :%@",error.localizedDescription);
            fail(error.localizedDescription);
            
        }
    }];
    
    [uploadTask resume];
}



+ (NSURLSessionDataTask *)JSONDataWithUrl:(NSString *)url parame:(NSMutableDictionary *)parameDic success:(void (^)(id json))success fail:(void (^)())fail{

    
    AFHTTPSessionManager *manager = [self httpSessionManager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    if (parameDic == nil) {
        parameDic = [[NSMutableDictionary alloc] init];
    }
    [parameDic setObject:@"json" forKey:@"format"];
    //    NSDictionary *dict = @{@"format": @"json"};
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    NSURLSessionDataTask* task=[manager GET:url parameters:parameDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(dataDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
        
    }];

    return task;
}
#pragma mark - xml方式获取数据
+ (void)XMLDataWithUrl:(NSString *)urlStr success:(void (^)(id xml))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [self httpSessionManager];
    
    // 返回的数据格式是XML
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSDictionary *dict = @{@"format": @"xml"};
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:urlStr parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
        
    }];

}

#pragma mark - JSON方式post提交数据
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [self httpSessionManager];
    // 设置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [PDDDataManger loadLoginCookie];
    
    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<null>" withString:@"\"\""];
              jsonString = [jsonString stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
           
            NSInteger status = [dic[@"code"] integerValue];
            
            
            if (status == 201) { //登录过期，需要重新登录，同时保存 cookie
                NSLog(@"返回 201 接口调用 -- %@",urlStr);
                
                [PDDDataManger cleanLoginCookie];
                [[LoginOperator shareInstance] ensconceLogin];
                [Dialog hideSVProgressHUD];
                
                return ;
            }
            
            success(dic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败原因--%@", error);
        if (fail) {
            fail();
        }
        
    }];
    
}

#pragma mark - JSON方式get提交数据
+ (void)getJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [self httpSessionManager];
    // 设置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            success(dic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败 --%@--%@",urlStr,error);
        if (fail) {
            fail();
        }
    }];
    
}


#pragma mark - Session 下载下载文件
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail
{
    AFURLSessionManager *manager = [self urlSessionManager];

    NSString *urlString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        // 将下载文件保存在缓存路径中
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        NSURL *fileURL = [NSURL fileURLWithPath:path];

        if (success) {
            success(fileURL);
        }
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath, error);
        if (fail) {
            fail();
        }
    }];
    
    [task resume];
}


#pragma mark - 文件上传 自己定义文件名
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPSessionManager *manager = [self httpSessionManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //@"image/png"
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:fileTye error:NULL];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(dic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) {
            fail();
        }
        
    }];
    
}

#pragma mark - POST上传文件
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [self httpSessionManager];
    
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // formData是遵守了AFMultipartFormData的对象
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 将本地的文件上传至服务器
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            fail();
        }
        
    }];
    

}



@end
