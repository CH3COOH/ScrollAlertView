//
//  ScrollAlertViewSampleAppDelegate.h
//  
//
//  Created by Wada Kenji on 11/07/18.
//  Copyright 2011 Softbuild. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollAlertViewSampleAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

