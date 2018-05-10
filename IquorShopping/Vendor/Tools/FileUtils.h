//
//  FileUtils.h
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

#pragma mark - 文件路径处理
/**获取documents目录*/
+ (NSString*) documentsDir;
+ (NSString *)libraryDir;
+ (NSString *)cacheDir;
+ (NSString *)tmpDir;

//获取documents下的文件路径
+ (NSString *)documentsPath:(NSString *)fileName;

#pragma mark - 文件处理
#pragma mark把文件内容读取到字典中
/**
 *把文件内容读取到字典中
 */
+ (NSDictionary *)dictionaryFromDocumentPath:(NSString *)fileName;

#pragma mark把文件内容读取到可变字典中
/**
 *把文件内容读取到可变字典中
 */
+ (NSMutableDictionary *)mutableDictionaryFromDocumentPath:(NSString *)fileName;

#pragma mark把文件内容读取到数组中
/**
 *把文件内容读取到数组中
 */
+ (NSArray *)arrayFromDocumentPath:(NSString *)fileName;

#pragma mark 把文件内容读取到可变数组中
/**
 *把文件内容读取到可变数组中
 */
+ (NSMutableArray *)mutableArrayFromDocumentPath:(NSString *)fileName;


#pragma mark把字典中的内容写到document的文件中
/**
 *把字典中的内容写到document的文件中
 */
+ (BOOL)writeDictionary:(NSDictionary *)dic toDocumentPath:(NSString *)fileName;

#pragma mark把数组中的内容写到document的文件中
/**
 *把数组中的内容写到document的文件中
 */
+ (BOOL)writeArray:(NSArray *)array toDocumentPath:(NSString *)fileName;

#pragma mark把字典中的内容写到Bundle的文件中
/**
 *把字典中的内容写到Bundle的文件中
 */
+ (NSDictionary *)dictionaryFromMainBundle:(NSString *)fileName;

#pragma mark把数组中的内容写到Bundle的文件中
/**
 *把数组中的内容写到Bundle的文件中
 */
+ (NSArray *)arrayFromMainBundle:(NSString *)fileName;


#pragma mark判断Document中的文件是否存在
/**
 *判断Document中的文件是否存在
 */
+ (BOOL)isFileExistInDocumentPath:(NSString *)fileName;

#pragma mark将Bundle中的文教copy到Document中
/**
 *将Bundle中的文教copy到Document中
 */
+ (void)copyToDocumentPathFromMainBundle:(NSString *)fileName;


#pragma mark删除document中的文件
/**
 *删除document中的文件
 */
+ (void)removeInDocumentPath:(NSString *)fileName;

#pragma mark字符串形式读取文件中的内容
/**
 *字符串形式读取文件中的内容
 */
+(NSString *) stringReadFile :(NSString *) fileName type:(NSString*)fileType;

#pragma mark 获取数据库路径
/**
 *获取数据库路径
 */
+(NSString *)getDataBaseFilePath;

#pragma mark 计算缓存大小
/**
 *计算缓存大小
 */
+ (long long) folderSizeAtPath:(NSString*)folderPath;
@end
