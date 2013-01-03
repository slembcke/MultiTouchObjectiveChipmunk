//
//  HelloWorldLayer.m
//  MultiTouchObjectiveChipmunk
//
//  Created by Scott Lembcke on 11/27/12.
//  Copyright Howling Moon Software 2012. All rights reserved.
//


#import "ObjectiveChipmunk.h"
#import "HelloWorldLayer.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer {
	ChipmunkSpace *_space;
	ChipmunkMultiGrab *_multiGrab;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	[scene addChild:[HelloWorldLayer node]];
	return scene;
}

-(id) init
{
	if((self = [super init])){
		self.touchEnabled = YES;
		
		_space = [[ChipmunkSpace alloc] init];
		_space.gravity = cpv(0, -200);
		
		CGSize size = [CCDirector sharedDirector].winSize;
		CGRect rect = CGRectMake(0, 0, size.width, size.height);
		[_space addBounds:rect thickness:5 elasticity:1 friction:1 layers:CP_ALL_LAYERS group:CP_NO_GROUP collisionType:nil];
		
		_multiGrab = [[ChipmunkMultiGrab alloc] initForSpace:_space withSmoothing:cpfpow(0.8, 60.0) withGrabForce:20000];
		
		// How close a touch has to be to an object to grab it. (should be about the size of the user's finger on the screen)
		_multiGrab.grabRadius = 20.0;
		
		// Torque to apply to grabs to slow down spinning.
		_multiGrab.grabRotaryFriction = 1e2;
		
		// Enable push mode. When an object isn't grabbed, it inserts a circle that tracks the touch instead.
		// This allows you to push things around.
		_multiGrab.pushMode = TRUE;
		
		// The friction on the push shape.
		_multiGrab.pushFriction = 0.7f;
		
		// The mass of the finger body. Should be about the same as the objects you intend to push, maybe a little less.
		_multiGrab.pushMass = 1.0;
		
		CCPhysicsDebugNode *debugNode = [CCPhysicsDebugNode debugNodeForChipmunkSpace:_space];
		[self addChild:debugNode];
		
		{ // Add a box
			cpFloat mass = 5;
			cpFloat width = 200;
			cpFloat height = 60;
			
			ChipmunkBody *body = [_space add:[ChipmunkBody bodyWithMass:mass andMoment:cpMomentForBox(mass, width, height)]];
			body.pos = cpv(100, 160);
			
			ChipmunkShape *shape = [_space add:[ChipmunkPolyShape boxWithBody:body width:width height:height]];
			shape.friction = 0.7;
		}
		
		{ // Add a circle
			cpFloat mass = 1;
			cpFloat radius = 50;
			
			ChipmunkBody *body = [_space add:[ChipmunkBody bodyWithMass:mass andMoment:cpMomentForCircle(mass, 0, radius, cpvzero)]];
			body.pos = cpv(400, 160);
			
			ChipmunkShape *shape = [_space add:[ChipmunkCircleShape circleWithBody:body radius:radius offset:cpvzero]];
			shape.friction = 0.7;
		}
		
		[self scheduleUpdate];
	}
	
	return self;
}

-(void)update:(cpFloat)dt
{
	[_space step:1.0/60.0];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
	for(UITouch *touch in touches) [_multiGrab beginLocation:[self convertTouchToNodeSpace:touch]];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
	for(UITouch *touch in touches) [_multiGrab updateLocation:[self convertTouchToNodeSpace:touch]];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
	for(UITouch *touch in touches) [_multiGrab endLocation:[self convertTouchToNodeSpace:touch]];
}


@end
