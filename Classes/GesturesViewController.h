//
//  GesturesViewController.h
//  Gestures
//
//  Created by lab13 on 11. 10. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GardenView;

@interface GesturesViewController : UIViewController 
{
	GardenView *gardenView;
	NSMutableArray *currentFlower;
}

@property (nonatomic, retain) GardenView *gardenView;

- (IBAction) handleObject:(id)sender;

- (IBAction) saveState:(id)sender;
- (IBAction) loadState:(id)sender;

@end

