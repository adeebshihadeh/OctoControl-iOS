//
//  Starscream.h
//  Starscream
//
//  Created by Austin Cherry on 9/25/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

#import <TargetConditionals.h>

#ifdef TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

//! Project version number for Starscream.
FOUNDATION_EXPORT double StarscreamVersionNumber;

//! Project version string for Starscream.
FOUNDATION_EXPORT const unsigned char StarscreamVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Starscream/PublicHeader.h>


