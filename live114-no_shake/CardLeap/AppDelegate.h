//
//  AppDelegate.h
//  CardLeap
//
//  Created by Sky on 14/11/20.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BaseEngine.h"
#define UmengAppkey @"55ec0f2fe0f55a3af4000622"
//获取相应的url
#define connect_url(key) [[[[[JSONOfNetWork getDictionaryFromPlist] objectForKey:@"obj"]objectForKey:@"api"]objectForKey:key] substringFromIndex:28]
//#define connect_url(key) [[[[[JSONOfNetWork getDictionaryFromPlist] objectForKey:@"obj"]objectForKey:@"api"]objectForKey:key] substringFromIndex:29]
//获取NSUserDefault中的数据
#define userDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

    
#pragma mark --- 2016.1.5 修改服务器地址为本地
#define baseUrl @"manager.114lives.com"
//#define baseUrl @"192.168.1.141/life114"


#define base_set @"base_set/ac_base"
#define UM_APP_KEY @"54d315c9fd98c5976a000141"
#define IS_USE_BASE64 @"YES"
// 当不处于乐享圈界面时有消息通过NSNotificationCenter进程内广播
#define NOTIFICATION_ROOT_NEW_MESSAGE                           (@"NOTIFICATION_ROOT_NEW_MESSAGE")
#define NOTIFICATION_CIRCLE_NEW_MESSAGE                           (@"NOTIFICATION_CIRCLE_NEW_MESSAGE")
#define NOTIFICATION_RIGHT_NEW_MESSAGE                           (@"NOTIFICATION_RIGHT_NEW_MESSAGE")


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic        ) float          systemVersion;/*!< 表示当前应用的操作系统版本号 */
@property (strong, nonatomic) NSString       *applicationVersion;/*!< 应用版本号 */
@property (strong, nonatomic) BaseEngine     *baseEngine;/*!< 网络层引擎的实例对象 */
@property (strong,nonatomic ) NSDictionary   * baseDict;
@property (assign, nonatomic) BOOL islogin;                     /*!< 是否登录 */
@property (strong, nonatomic) NSString *deviceID;
-(void)getDataFromNet;

@end

