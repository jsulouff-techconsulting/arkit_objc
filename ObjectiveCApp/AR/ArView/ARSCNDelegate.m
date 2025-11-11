//
//  ARSCNDelegate.m
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/11/25.
//

#import <Foundation/Foundation.h>
#import "ARHeader.h"

@implementation ARSCNDelegate

- (void)session:(ARSession*) session didFailWithError:(NSError *)error {
    NSLog(@"Session failed: %@", [error debugDescription]);
}

- (void)sessionWasInterrupted:(ARSession*) session {
    NSLog(@"Session Interrupted: %@", [session debugDescription]);
}

- (void)sessionInterruptionEnded:(ARSession*) session {
    NSLog(@"Session Resumed: %@", [session debugDescription]);
}

@end
