//
//  VCardsAppDelegate.h
//  V-Cards
//
//  Created by Christopher Zahka on 9/27/13.
//  Copyright (c) 2013 Christopher Zahka. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GREEN_COLOR [UIColor colorWithRed:32.0f/255.0f green:196.0f/255.0f blue:0 alpha:0.8]

#ifndef DEBUG
#define GOOGLE_TRACKING_ID @"UA-44442599-1"
#else
#define GOOGLE_TRACKING_ID @"0000000000" //use nonsense 
#endif

@interface VCardsAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
