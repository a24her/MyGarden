//
//  Room.h
//  Gestures
//
//  Created by lab14 on 11. 11. 11..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// 방번호만 추가하기 위한 확장 UIView
@interface GardenView : UIView {
	NSInteger gardenNumber;
}

@property (assign) NSInteger gardenNumber;

@end