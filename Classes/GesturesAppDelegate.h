//
//  GesturesAppDelegate.h
//  Gestures
//
//  Created by lab13 on 11. 10. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GesturesViewController;

@interface GesturesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GesturesViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GesturesViewController *viewController;

@end

