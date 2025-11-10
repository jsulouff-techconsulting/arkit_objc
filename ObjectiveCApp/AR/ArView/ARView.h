//
//  ARView.h
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/10/25.
//

#import <ARKit/ARKit.h>
#import "ARSCNDelegate.h"

@interface ARView : UIViewController
    @property ARSession* arSession;
    @property ARWorldTrackingConfiguration* arConf;

    @property ARAnchor* anchor;
    
    @property ARSCNView* arviewer;
    @property ARSCNDelegate* arDelegate;

@end
