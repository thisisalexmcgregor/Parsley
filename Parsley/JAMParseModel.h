//
//  JAMParseModel.h
//
//  Created by Alex McGregor on 11/12/15.
//  Copyright © 2015 Alex McGregor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JAMParseSerializer.h"

@interface JAMParseModel : NSObject

@property (nonatomic, strong) NSDictionary *propertyMap;
@property (nonatomic, strong) NSSet *propertyKeys;

- (Class)classForKeyValue:(NSString *)keyValue;

@end
