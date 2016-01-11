//
//  JAMParseAdapter.m
//
//  Created by Alex McGregor on 11/12/15.
//  Copyright © 2015 Alex McGregor. All rights reserved.
//

#import "JAMParseAdapter.h"
#import <objc/runtime.h>

NSString * const JAMParseAdapterErrorDomain = @"JAMParseAdapterErrorDomain";
NSInteger const JAMParseAdapterErrorInvalidParseArray = 1;
NSInteger const JAMParseAdapterErrorInvalidParseDictionary = 2;

@implementation JAMParseAdapter

+ (PFObject *)parseObjectForModel:(id<JAMParseSerializer>)model
{
    NSParameterAssert([model conformsToProtocol:@protocol(JAMParseSerializer)]);
    
    PFObject *parseObject = [[PFObject alloc] initWithClassName:[[model class] className]];
    
    NSDictionary *propertyMap = [(JAMParseModel *)model propertyMap];
    
    NSArray *parseKeyValues = [[[model class] parseDictionary] allKeys];
    
    for (NSString *key in parseKeyValues)
    {
        if ([propertyMap objectForKey:key] != nil)
        {
            id object = [propertyMap objectForKey:key];
            if ([object isKindOfClass:[NSURL class]])
                    object = [object absoluteString];
            [parseObject setObject:object forKey:key];
        }
    }
    
    return parseObject;
}

+ (id<JAMParseSerializer>)objectForClass:(Class<JAMParseSerializer>)modelClass parseObject:(PFObject *)parseObject
{
    NSDictionary *parseDictionary = [modelClass.class parseDictionary];
    id <JAMParseSerializer>object = [[modelClass.class alloc] init];
    
    for (NSString *parseKey in parseDictionary.allKeys)
    {
        NSString *modelPropertyKey = [parseDictionary objectForKey:parseKey];
        id value = [parseObject valueForKey:parseKey];
        Class modelPropertyClass = [(JAMParseModel *)object classForKeyValue:modelPropertyKey];
        
        if ([[modelPropertyClass description] isEqualToString:@"NSURL"] && [value isKindOfClass:[NSString class]])
        {
            NSURL *URL = [NSURL URLWithString:value];
            value = URL;
        }
        if (value)
        {
            [(JAMParseModel *)object setValue:value forKey:modelPropertyKey];
        }
    }
    
    return object;
}

+ (NSArray *)modelsOfClass:(Class<JAMParseSerializer>)modelClass fromParseArray:(NSArray *)result parsingError:(NSError **)error
{
    // TODO More error handling
    if (result == nil || ![result isKindOfClass:NSArray.class]) {
        if (error != NULL) {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: NSLocalizedString(@"Missing JSON array", @""),
                                       NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"%@ could not be created because an invalid JSON array was provided: %@", @""), NSStringFromClass(modelClass), result.class],
                                       };
            *error = [NSError errorWithDomain:JAMParseAdapterErrorDomain code:JAMParseAdapterErrorInvalidParseArray userInfo:userInfo];
        }
        return nil;
    }
    else
    {
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:result.count];
        for (PFObject *parseObject in result)
        {
            id<JAMParseSerializer>object = [self objectForClass:modelClass parseObject:parseObject];
            [models addObject:object];
        }
        
        return models;
    }
}


@end
