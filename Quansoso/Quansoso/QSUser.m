//
//  QSUser.m
//  Quansoso
//
//  Created by qf on 14/10/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSUser.h"
#import "SynthesizeSingleton.h"
#import <TAESDK/TAESDK.h>

@implementation QSUser

SYNTHESIZE_SINGLETON_FOR_CLASS(QSUser);

- (TaeUser *)user{
	if (!_user) {
		
	}
	return _user;
}

- (void)ifUnloginIn:(UIViewController *) currentVC{
	if (![[TaeSession sharedInstance] isLogin]) {
		[[TaeSDK sharedInstance] showLogin:currentVC successCallback:^(TaeSession *session) {
			_user = [[TaeSession sharedInstance] getUser];
		} failedCallback:^(NSError *error) {
			
		}];
	}else{
		_user = [[TaeSession sharedInstance] getUser];
	}
}

@end
