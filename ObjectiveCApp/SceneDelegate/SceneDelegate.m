//
//  SceneDelegate.m
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 10/29/25.
//

#import "PHASECTL.h"

#import "ObjectiveCApp-Swift.h"

#import "SceneDelegate.h"
#import "AppDelegate.h"

#import "ListViewController.h"
#import "ARHeader.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

#define USE_SWIFTUI_ARVIEW true

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    printf("Entering SceneDelegate scene code\n");
    UIWindow* window = [[UIWindow alloc] initWithWindowScene: (UIWindowScene*) scene];
    
    
#if PHASE < 1
    ListViewController* homeViewController = [[ListViewController alloc]init];
#else
    
#if USE_SWIFTUI_ARVIEW
        UIViewController* homeViewController = [[[SwiftArInterface alloc] init] mkSwiftArViewUi];
#else
        ARView* homeViewController = [[ARView alloc] init];
#endif
#endif
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    [window setRootViewController:nav];
    [window makeKeyAndVisible];
    self.window = window;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}


@end
