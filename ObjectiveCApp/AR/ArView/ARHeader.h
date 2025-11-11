//
//  ARHeader.h
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/11/25.
//
#import <ARKit/ARKit.h>

@class ARView;
@class ARGestureDelegate;
@class ARSCNDelegate;

@interface ARView : UIViewController
    @property ARSCNView* arviewer;
    
    @property ARSCNDelegate* arDelegate;
    @property ARGestureDelegate* gestureDelegate;
@end

@interface ARGestureDelegate : NSObject
    @property ARView* arView;
    @property(weak) SCNNode* selectedObject;
    
    - (void) setupGestureRecognizer;
@end

@interface ARSCNDelegate : NSObject<ARSCNViewDelegate, ARSessionDelegate>

@end
