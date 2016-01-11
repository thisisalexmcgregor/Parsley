//
//  JAMParseSerializer.h
//
//  Created by Alex McGregor on 11/12/15.
//  Copyright © 2015 Alex McGregor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JAMParseSerializer <NSObject>

+ (NSDictionary *)parseDictionary;
+ (NSString *)className;

@end
