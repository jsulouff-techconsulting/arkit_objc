//
//  AppDelegate.h
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 10/29/25.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

