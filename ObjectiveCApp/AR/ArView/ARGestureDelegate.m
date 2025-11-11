//
//  ARGestureDelegate.m
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/11/25.
//

#import <Foundation/Foundation.h>
#import "ARHeader.h"


@implementation ARGestureDelegate

- (void)setupGestureRecognizer {
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Handler:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.arView.arviewer addGestureRecognizer:tapGestureRecognizer];
}

- (void) tap1Handler:(UITapGestureRecognizer*) recognizer {
    NSLog(@"TAP HANDLING");
    [self placeObjectAtGesture:recognizer];
}

- (void) pinchHandler:(UIPinchGestureRecognizer*) recognizer {
    
}

- (void) panHandler:(UIPanGestureRecognizer*) recognizer {
    
}

- (void) placeObjectAtGesture:(UIGestureRecognizer*) recognizer {
    CGPoint tapPoint = [recognizer locationInView:self.arView.arviewer];
    NSArray<ARHitTestResult*>* result = [self.arView.arviewer hitTest:tapPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
    
    ARHitTestResult* hitResult = [result firstObject];
    if (hitResult) {
        NSString* SPAWN_SCENE = @"visionTest.usdc";
        SCNScene* scene = [SCNScene sceneNamed:SPAWN_SCENE];
        
        SCNNode *node = [scene.rootNode clone];
        float insertionYOffset = 0.01;
        node.position = SCNVector3Make(
                                           hitResult.worldTransform.columns[3].x,
                                           hitResult.worldTransform.columns[3].y + insertionYOffset,
                                           hitResult.worldTransform.columns[3].z
                                           );
        [node setScale:SCNVector3Make(0.1, 0.1, 0.1)];
        [self.arView.arviewer.scene.rootNode addChildNode:node];
        
    }
        
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
