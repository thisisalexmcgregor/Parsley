//
//  JAMParseModel.m
//
//  Created by Alex McGregor on 11/12/15.
//  Copyright © 2015 Alex McGregor. All rights reserved.
//

#import "JAMParseModel.h"
#import <objc/runtime.h>

@implementation JAMParseModel

- (NSDictionary *)propertyMap
{
    NSMutableDictionary *propertyMap = [NSMutableDictionary dictionary];
    unsigned count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSInteger i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id object = [self objectForPropertyName:propertyName];
        if (object)
        {
            [propertyMap setObject:object forKey:propertyName];
        }
    }
    
    free(properties);
    
    return propertyMap;
}

- (Class)classForKeyValue:(NSString *)keyValue
{
    unsigned count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSInteger i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if ([propertyName isEqualToString:keyValue])
        {
            NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
            if (splitPropertyAttributes.count > 0)
            {
                NSString *encodeType = splitPropertyAttributes[0];
                NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
                NSString *className = splitEncodeType[1];
                
                free(properties);
                return NSClassFromString(className);
            }
        }
    }
    
    if ([self superclass] != [JAMParseModel class])
    {
        unsigned superClassCount = 0;
        objc_property_t *superclassProperties = class_copyPropertyList([self superclass], &superClassCount);
        
        NSInteger index;
        
        for (index = 0; index < count; index++)
        {
            objc_property_t property = superclassProperties[index];
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            if ([propertyName isEqualToString:keyValue])
            {
                NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
                NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
                if (splitPropertyAttributes.count > 0)
                {
                    NSString *encodeType = splitPropertyAttributes[0];
                    NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
                    NSString *className = splitEncodeType[1];
                    
                    free(superclassProperties);
                    return NSClassFromString(className);
                }
            }
        }
        
        free(superclassProperties);
    }
    
    free(properties);
    
    return nil;
}

- (id)objectForPropertyName:(NSString *)propertyName
{
    return [self valueForKey:propertyName];
}

- (NSSet *)propertyKeys
{
    NSMutableSet *keys = [NSMutableSet set];
    
    unsigned count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSInteger i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        [keys addObject:propertyName];
    }
    
    free(properties);
    
    return keys;
}

@end
