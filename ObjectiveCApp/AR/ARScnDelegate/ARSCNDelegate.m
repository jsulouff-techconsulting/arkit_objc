//
//  ARSCNDelegate.m
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/10/25.
//

#import <Foundation/Foundation.h>
#import "ARSCNDelegate.h"

@implementation ARSCNDelegate

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    NSLog(@"THE SESSION HAS FAILED (%@).\n", [error localizedDescription]);
}

- (void)sessionWasInterrupted:(ARSession *)session {
    NSLog(@"THE SESSION WAS INTERRUPTED.\n");
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}

@end
