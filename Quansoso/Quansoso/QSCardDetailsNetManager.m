//
//  QSCardDetails.m
//  Quansoso
//
//  Created by qf on 14/11/24.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCardDetailsNetManager.h"
#import "NetManager.h"
#import <CommonCrypto/CommonDigest.h>
#define kURLMerchant @"http://quansoso.uz.taobao.com/d/cr/rest"
#define kURLItems @"http://gw.api.taobao.com/router/rest?sign=70EE3443872ECC4028CF5CA3778E1CE3&v=2.0&app_key=23018056&method=taobao.aitaobao.items.relate.get&partner_id=top-apitools&format=json&relate_type=4&fields=num_iid%2Ctitle%2Cnick%2Cpic_url%2Cprice%2Cclick_url"
@implementation QSCardDetailsNetManager
- (void)getCardUseCouponId:(NSString *)couponId andNick:(NSString *)nick success:(void (^)(NSString* describe))succ failure:(void (^)(NSString* describe))failure{
//	NSDictionary *dic = @{@"nick":nick,@"couponId":couponId,@"service":@"exchange"};
//	NSString *encodedStr = [kURLMerchant stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *url = [NSString stringWithFormat:@"%@?service=exchange&nick=%@&couponId=%@",kURLMerchant,nick,couponId];
	NSString *encodeStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFPropertyListParameterEncoding succ:^(NSDictionary *successDict) {
		bool result = [successDict[@"isSuccess"] boolValue];
		NSString *resultStr = successDict[@"describe"];
		if(result){
			succ(resultStr);
		}else{
			failure(resultStr);
		}
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure(@"error");
	}];
}
- (void)getItemsSellerId:(NSString *)sellerId success:(void (^)(NSArray *items))succ failure:(void (^)())failure{
	NSString *strcurrenttime = [self getCurrentDate];
	NSDictionary *dict = @{@"timestamp":strcurrenttime,@"v":@"2.0",};
	NSString *url = [NSString stringWithFormat:@"%@&timestamp=%@&seller_id=%@",kURLItems,[self getCurrentDate],sellerId];
	[NetManager requestWith:nil url:url method:@"GET" operationKey:nil parameEncoding:AFPropertyListParameterEncoding succ:^(NSDictionary *successDict) {
		MLOG(@"");

	} failure:^(NSDictionary *failDict, NSError *error) {
		failure();
	}];
}
- (NSString *)md5:(NSString *)str {
	const char *cStr = [str UTF8String];//转换成utf-8
	unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
	CC_MD5( cStr, strlen(cStr), result);
	/*
	 extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
	 把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
	 */
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
	/*
	 x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
	 NSLog("%02X", 0x888);  //888
	 NSLog("%02X", 0x4); //04
	 */
}

- (NSString *)getCurrentDate{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
	//dateFormatter通过setTimeZone来设置正确的时区
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
	NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
	return dateString;//[dateString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
