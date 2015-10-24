//
//  TNSDBCenter.m
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/25.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import <FMDB/FMDB.h>

#import "TNSDBCenter.h"

#import "NSDate+Milliseconds.h"
#import "NSDate+FormatDate.h"

static NSString * const TNSDatabaseDirectoryRelativePath = @"/TNSDatabase";
static NSString * const TNSDatabaseRelativePath          = @"/TNSDatabase/TNSDB.sqlite";

static NSString * const TNSNightShiftPhotosTable         = @"NightShiftPhotosTable";

@interface TNSDBCenter ()

@property (nonatomic, copy  ) NSString         *dbAbsolutePath;

@property (nonatomic, strong) dispatch_queue_t dbQueue;

@end

@implementation TNSDBCenter

+ (void)insertRecordIntoNightShiftPhotosTableWithImage:(UIImage *)image takeTime:(NSNumber *)takeTime
{
    if (!image || !takeTime) {
        NSLog(@"插入照片而信息不全，插入取消");
        return ;
    }
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (archievedData, takeTime) VALUES (:archievedData, :takeTime)", TNSNightShiftPhotosTable];
    __weak typeof(self) weaskSelf = self;
    [weaskSelf executeSQLsUsingSharedDBCenterInBlock:^(FMDatabase *db) {
        [db executeUpdate:sql withParameterDictionary:@{@"archievedData": UIImageJPEGRepresentation(image, 1.0),
                                                        @"takeTime": takeTime}];
    }];
}

+ (void)selectRecordsOfTodayWhenOK:(void (^)(BOOL, NSArray *))block
{
    if (!block) {
        NSLog(@"数据库查询缺少回调block。");
        return ;
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT archievedData,takeTime FROM %@ where takeTime<? and takeTime>=? order by takeTime desc", TNSNightShiftPhotosTable];
    [self executeSQLsUsingSharedDBCenterInBlock:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql, [NSDate millisecondsNumberSince1970], [[[NSDate formatterYMD] dateFromString:[[NSDate date] presentation_YMD]] millisecondsNumberSince1970]];
        if (rs == nil) {
            NSLog(@"查询数据库出现问题 - 无法执行查询语句");
            dispatch_async(dispatch_get_main_queue(), ^{
                block(NO, nil);
            });
        } else {
            NSMutableArray *records = [NSMutableArray array];
            while ([rs next]) {
                [records addObject:@{@"archievedData": [rs dataForColumnIndex:0],
                                     @"takeTime": [rs dataForColumnIndex:1]}];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(YES, records);
            });
        }
        [rs close];
    }];
}

#pragma mark - call when first time creating tables

- (void)createDatabaseDirectory {
    NSString *filepath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dbDirectoryAbsolutePath = [NSString stringWithFormat:@"%@%@", filepath, TNSDatabaseDirectoryRelativePath];
    if (![fm fileExistsAtPath:dbDirectoryAbsolutePath]) {
        [fm createDirectoryAtPath:dbDirectoryAbsolutePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        [self executeSQLsInBlock:^(FMDatabase *db) {
            NSString *sqls_createTables = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"_DatabaseTables" ofType:@"sql"] encoding:NSUTF8StringEncoding error:nil];
            [db executeStatements:sqls_createTables];
        }];
    }
}

#pragma mark - call when executing SQL

+ (void)executeSQLsUsingSharedDBCenterInBlock:(void (^)(FMDatabase *db))block {
    [[self sharedCenter] executeSQLsInBlock:block];
}

- (void)executeSQLsInBlock:(void (^)(FMDatabase *db))block
{
    if (block != nil) {
        dispatch_async(self.dbQueue, ^{
            FMDatabase *db = [FMDatabase databaseWithPath:self.dbAbsolutePath];
            [db open];
            block(db);
            [db close];
        });
    } else {
        NSLog(@"操作数据库 - 没有可执行的block!");
    }
}

#pragma mark - common things

+ (TNSDBCenter *)sharedCenter
{
    static TNSDBCenter *__shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shared = [[TNSDBCenter alloc] init];
        [__shared setup];
    });
    
    return __shared;
}

- (void)setup
{
    NSString *filepath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.dbAbsolutePath = [NSString stringWithFormat:@"%@%@", filepath, TNSDatabaseRelativePath];
    
    // 操作数据库队列，串行模式，保证线程安全
    self.dbQueue = dispatch_queue_create("com.toast.NightShift.db", DISPATCH_QUEUE_SERIAL);
    
    // 若数据表库不存在则创建数据库并创建数据表
    [self createDatabaseDirectory];
}

@end
