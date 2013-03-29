//
//  NSString+Additions.m
//  MapKit
//
//  Created by Zach Drayer on 3/29/13.
//
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (id) JSONValue
{
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	return [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)0 error:NULL];
}

@end
