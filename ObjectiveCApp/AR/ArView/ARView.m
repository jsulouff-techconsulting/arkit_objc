//
//  ARView.m
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/10/25.
//
#import "ARView.h"
#import <Foundation/Foundation.h>
#import <ARKit/ARKit.h>

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
    SCNScene *scene = [SCNScene sceneNamed:@"cup.dae"];
    SCNNode *modelNode = scene.rootNode.childNodes[0];
    [modelNode setScale:SCNVector3Make(0.1, 0.1, 0.1)]; // Scale the model
    ARAnchor *cupAnchor = [[ARAnchor alloc] initWithTransform:modelNode.simdTransform];
    
    self.arviewer.scene = scene;
    
    self.arConf = [[ARWorldTrackingConfiguration alloc] init];
    self.arConf.planeDetection = ARPlaneDetectionHorizontal;
    
    self.arSession = [[ARSession alloc] init];
    [self.arSession addAnchor:cupAnchor];
    [self.arSession runWithConfiguration:self.arConf];
    
    self.arviewer.session = self.arSession;
    
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
