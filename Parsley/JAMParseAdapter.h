//
//  JAMParseAdapter.h
//
//  Created by Alex McGregor on 11/12/15.
//  Copyright © 2015 Alex McGregor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "JAMParseModel.h"
#import "JAMParseSerializer.h"

@interface JAMParseAdapter : NSObject

+ (PFObject *)parseObjectForModel:(id<JAMParseSerializer>)model;

+ (NSArray *)modelsOfClass:(Class<JAMParseSerializer>)modelClass fromParseArray:(NSArray *)result parsingError:(NSError **)error;

@end
