//
//  ARView.m
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/10/25.
//

#import <Foundation/Foundation.h>
#import <ARKit/ARKit.h>
#import "ARHeader.h"

@implementation ARView

-(void) viewDidLoad {
    NSLog(@"ARVIEW LOADED");
    NSLog(@"VIEW TRACKING SUPPORT: %d", ARWorldTrackingConfiguration.isSupported);
    
    self.arDelegate = [[ARSCNDelegate alloc] init];
    
    self.arviewer = [[ARSCNView alloc] initWithFrame:self.view.frame];
    self.arviewer.delegate = self.arDelegate;
    
    NSLog(@"ARVIEWER WINDOW: %f %f", self.arviewer.frame.size.width,self.arviewer.frame.size.height);
    
    self.arviewer.showsStatistics = true;
    self.arviewer.autoenablesDefaultLighting = true;
    
    [self checkMediaPerms];
    
    // Place 3D model so i can see what the fuck is wrong (camera or arkit)
    SCNScene *scene = [SCNScene sceneNamed:@"visionTest.usdc"];
    SCNNode *modelNode = scene.rootNode.childNodes[0];
    [modelNode setScale:SCNVector3Make(0.1, 0.1, 0.1)]; // Scale the model
    ARAnchor *cupAnchor = [[ARAnchor alloc] initWithTransform:modelNode.simdTransform];
    
    self.arviewer.scene = scene;
    
    ARWorldTrackingConfiguration* arConf = [[ARWorldTrackingConfiguration alloc] init];
    arConf.planeDetection = ARPlaneDetectionHorizontal;
    
    ARSession* arSession = [[ARSession alloc] init];
    [arSession addAnchor:cupAnchor];
    [arSession runWithConfiguration:arConf];

    self.arviewer.session = arSession;
    
    self.gestureDelegate = [[ARGestureDelegate alloc] init];
    self.gestureDelegate.arView = self;
    
    [self.gestureDelegate setupGestureRecognizer];
    
    [self.view addSubview:self.arviewer];
}

-(void) checkMediaPerms {
    dispatch_async(dispatch_get_main_queue(), ^{
        AVAuthorizationStatus authStat = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStat == AVAuthorizationStatusAuthorized || authStat == AVAuthorizationStatusNotDetermined) {
            NSLog(@"[OK] ACCESS FOR AV GRANTED.");
        }
        else {
            NSLog(@"[WARN] ACCESS FOR AV DENIED, CHECK PERMS AGAIN.");
        }
    });
}

@end
