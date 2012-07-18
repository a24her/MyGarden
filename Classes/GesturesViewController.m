//
//  GesturesViewController.m
//  Gestures
//
//  Created by lab13 on 11. 10. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GesturesViewController.h"
#import "Flower.h"
#import "GardenView.h"


@implementation GesturesViewController

@synthesize gardenView;

// 패닝(드래깅) 메서드에서 사용을 위해 전역으로 선언
CGPoint netTranslation;

int flowersWidth = 48;
int flowersHeight = 48;

- (IBAction) saveState:(id)sender {

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	NSString *filePath = [documentsDir stringByAppendingPathComponent:@"save.dat"];

	NSMutableString *saveString = [[NSMutableString alloc] initWithString:@""];
	for (Flower *aFlower in currentFlower) {
		saveString = [saveString stringByAppendingFormat:@"%i", aFlower.flowerNumber];
		saveString = [saveString stringByAppendingString:@"|"];
		saveString = [saveString stringByAppendingFormat:@"%f.%f.%f.%f", 
					  aFlower.frame.origin.x, aFlower.frame.origin.y,
					  aFlower.frame.size.width, aFlower.frame.size.height];
		saveString = [saveString stringByAppendingString:@"#"];
	}
	
	//NSLog(@"%@",saveString);
	
	// 저장시작
	BOOL result = [saveString writeToFile:filePath atomically:YES];

	if (result) {
		NSString *msg = @"저장성공";
	} else {
		NSString *msg = @"저장실패";
	}

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
													message:@"곧 저장 기능을 만들거에요."
												   delegate:self
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

- (IBAction) loadState:(id)sender {

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	NSString *filePath = [documentsDir stringByAppendingPathComponent:@"save.dat"];

	NSString *loadData = [NSString stringWithContentsOfFile:filePath];
	
	NSArray *flowers = [loadData componentsSeparatedByString:@"#"];
	
	for (NSString *flowerInfoString in flowers) {

		NSArray *flowerInfos = [flowerInfoString componentsSeparatedByString:@"|"];
		NSLog(@"%@", flowerInfos);
		
	}
	
}


- (IBAction) handleObject:(id)sender {
	
	CGRect frame;
	UIImage *imageSrc;
	
	switch ([sender tag]) {
		case 1:
			frame = CGRectMake(0, 0, flowersWidth, flowersHeight);
			imageSrc = [UIImage imageNamed:@"African Daisy.gif"];
			break;
		case 2:
			frame = CGRectMake(0, 0, flowersWidth, flowersHeight);			
			imageSrc = [UIImage imageNamed:@"Dandelion.gif"];
			break;
		case 3:
			frame = CGRectMake(0, 0, flowersWidth, flowersHeight);			
			imageSrc = [UIImage imageNamed:@"Ixia.gif"];
			break;
		case 4:
			frame = CGRectMake(0, 0, flowersWidth, flowersHeight);			
			imageSrc = [UIImage imageNamed:@"Sunflower.gif"];
			break;
		default:
			return;
			
	}
	
	Flower *aFlower = [[Flower alloc]initWithImage:imageSrc];
	aFlower.userInteractionEnabled = YES;
	aFlower.frame = frame;
	aFlower.flowerNumber = [sender tag]; // Flower번호 저장

	// 팬제스처생성
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
										  initWithTarget:self
										  action:@selector(handlePanGesture:)];
	[aFlower addGestureRecognizer:panGesture];
	[panGesture release];

	[self.gardenView addSubview:aFlower]; // 동적생성 이미지뷰를 가든에 삽입

	// 생성한 이미지를 꽃일람에 저장
	[currentFlower addObject:aFlower];

}

// 팬 제스처 처리
- (IBAction) handlePanGesture:(UIGestureRecognizer *)sender {
	
	if (sender.state == UIGestureRecognizerStateBegan) {
		netTranslation.x = sender.view.frame.origin.x;
		netTranslation.y = sender.view.frame.origin.y;
		
		//[gardenView bringSubviewToFront:sender.view];
	}

	CGPoint translation = [(UIPanGestureRecognizer *)sender translationInView:sender.view];

	float newX = netTranslation.x + translation.x;
	float newY = netTranslation.y + translation.y;

	sender.view.transform = CGAffineTransformMakeTranslation(newX,newY);	
	
	if (sender.state == UIGestureRecognizerStateEnded) {
		sender.view.frame = CGRectMake(newX, newY, flowersWidth, flowersHeight);
	}
	

}


- (void)viewDidLoad {

	[super viewDidLoad];

	// Save를 위한 currentGarden 을 동적메모리 생성
	currentFlower = [[NSMutableArray alloc] init]; // 꽃일람을 생성

	// 정원생성
	gardenView = [[GardenView alloc] init];
	gardenView.gardenNumber = 1; // 기본값으로 그냥 1로 초기화 한다.
	CGRect frame = CGRectMake(12, 88, 288, 263);
	gardenView.frame = frame;
	gardenView.backgroundColor = UIColor.grayColor;
	gardenView.clipsToBounds = YES;
	[self.view addSubview:gardenView];

}

- (void)dealloc {
	
	[gardenView release];
	[currentFlower release];
	
    [super dealloc];

}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
