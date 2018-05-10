//
//  FileUtils.m


#import "FileUtils.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/stat.h>
#include <dirent.h>

@implementation FileUtils

#pragma mark - 文件路径处理
#pragma mark 获取documents目录
+(NSString*) documentsDir
{
    return [ NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory , NSUserDomainMask , YES ) objectAtIndex : 0];
}
#pragma mark 获取library目录
+ (NSString *)libraryDir
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory , NSUserDomainMask,YES) objectAtIndex:0];
}
#pragma mark 获取Cache目录
+ (NSString *)cacheDir
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory , NSUserDomainMask,YES) objectAtIndex:0];
}
#pragma mark 获取Tmp目录
+ (NSString *)tmpDir
{
    return NSTemporaryDirectory();
}
#pragma mark 获取文件在Bundle目录
+ (NSString *)bundlePath:(NSString *)fileName
{
    return [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
}
#pragma mark 获取documents下的文件路径
+ (NSString *)documentsPath:(NSString *)fileName {
    
    NSString *path = [[self documentsDir] stringByAppendingPathComponent:fileName];
    
    return path;
}

//---------------------------
#pragma mark - 文件处理
#pragma mark 把文件内容读取到字典中
+ (NSDictionary *)dictionaryFromDocumentPath:(NSString *)fileName
{
    return [NSDictionary dictionaryWithContentsOfFile:[self documentsPath:fileName]];
}

#pragma mark 把文件内容读取到可变字典中
+ (NSMutableDictionary *)mutableDictionaryFromDocumentPath:(NSString *)fileName
{
    return (NSMutableDictionary *)[NSDictionary dictionaryWithContentsOfFile:[self documentsPath:fileName]];
    
}

#pragma mark 把文件内容读取到数组中
+ (NSArray *)arrayFromDocumentPath:(NSString *)fileName
{
    return [NSArray arrayWithContentsOfFile:[self documentsPath:fileName]];
}

#pragma mark 把文件内容读取到可变数组中
+ (NSMutableArray *)mutableArrayFromDocumentPath:(NSString *)fileName
{
    return [NSMutableArray arrayWithContentsOfFile:[self documentsPath:fileName]];
}

#pragma mark 把字典中的内容写到document的文件中
+ (BOOL)writeDictionary:(NSDictionary *)dic toDocumentPath:(NSString *)fileName
{
   BOOL isSuc= [dic writeToFile:[self documentsPath:fileName] atomically:YES];
    return isSuc;
}

#pragma mark 把数组中的内容写到document的文件中
+ (BOOL)writeArray:(NSArray *)array toDocumentPath:(NSString *)fileName
{
   BOOL isSuc= [array writeToFile:[self documentsPath:fileName] atomically:YES];
    return isSuc;
}

#pragma mark 把字典中的内容写到Bundle的文件中
+ (NSDictionary *)dictionaryFromMainBundle:(NSString *)fileName
{
    return [NSDictionary dictionaryWithContentsOfFile:[self bundlePath:fileName]];
}

#pragma mark 把数组中的内容写到Bundle的文件中
+ (NSArray *)arrayFromMainBundle:(NSString *)fileName
{
    return [NSArray arrayWithContentsOfFile:[self bundlePath:fileName]];
}

#pragma mark 判断Document中的文件是否存在
+ (BOOL)isFileExistInDocumentPath:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[self documentsPath:fileName]];
}

#pragma mark 将Bundle中的文教copy到Document中
+ (void)copyToDocumentPathFromMainBundle:(NSString *)fileName
{
    if (![self isFileExistInDocumentPath:fileName]) {
        NSString *bundlePath = [self bundlePath:fileName];
        NSString *documentPath = [self documentsPath:fileName];
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager copyItemAtPath:bundlePath toPath:documentPath error:nil];
    }
}

#pragma mark 删除document中的文件
+ (void)removeInDocumentPath:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = [self documentsPath:fileName];
    [fileManager removeItemAtPath:fullPath error:nil];
}

#pragma mark 字符串形式读取文件中的内容
+(NSString *) stringReadFile :(NSString *) fileName type:(NSString*)fileType
{
    NSError *error;
	NSMutableString *textContents = [NSMutableString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:fileType] encoding:NSUTF8StringEncoding error:&error];
    
    if (textContents == nil) {
        NSLog(@"Error reading text file. %@", [error localizedFailureReason]);
    }
	return textContents;
    
}

#pragma mark 获取数据录路径
+(NSString *)getDataBaseFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDiectory = [paths objectAtIndex:0];
    NSString *sDataBasePath = [docDiectory stringByAppendingPathComponent:DBName];
    NSLog(@"databasePath:%@", sDataBasePath);
    return sDataBasePath;
}
#pragma mark - 获取应用程序缓存大小
+ (long long) folderSizeAtPath:(NSString*)folderPath{
    return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}
//Private
+ (long long) _folderSizeAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}

@end
