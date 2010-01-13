//
//  QTXAutoPlayFullscreen.m
//  QTXAutoPlayFullscreen
//
//  Created by Marcel Vingerling on 09-10-09.
//  Copyright 2009 Strawberries. All rights reserved.
//

#import <objc/runtime.h>
#import "QTXAutoPlayFullscreen.h"
#import "NSObject+QTXAutoPlayFullscreenHook.h"

@implementation QTXAutoPlayFullscreen

+(void) load
{
	Method oldHook = class_getInstanceMethod(objc_getClass("MGDocumentWindowController"), @selector(toggleFullScreen:));
	Method newHook = class_getInstanceMethod(objc_getClass("MGDocumentWindowController"), @selector(QTXAutoPlayFullscreen_toggleFullScreen:));
	method_exchangeImplementations(oldHook, newHook);
	
	
	Method oldDealloc = class_getInstanceMethod(objc_getClass("MGDocumentWindowController"), @selector(dealloc));
	Method newDealloc = class_getInstanceMethod(objc_getClass("MGDocumentWindowController"), @selector(QTXAutoPlayFullscreen_dealloc));
	method_exchangeImplementations(oldDealloc, newDealloc);
	
	NSLog(@"QTXAutoPlayFullscreen is now active");
	
	if (nil == [[NSUserDefaults standardUserDefaults] objectForKey:QTX_AUTOPLAY_USER_DEFAULT_KEY]) {		
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:QTX_AUTOPLAY_USER_DEFAULT_KEY];
		[[NSUserDefaults standardUserDefaults] synchronize];
		NSLog(@"Created userdefault key: %@", QTX_AUTOPLAY_USER_DEFAULT_KEY); 
	}
	
	if (nil == [[NSUserDefaults standardUserDefaults] objectForKey:QTX_AUTORESIGN_USER_DEFAULT_KEY]) {		
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:QTX_AUTORESIGN_USER_DEFAULT_KEY];
		[[NSUserDefaults standardUserDefaults] synchronize];
		NSLog(@"Created userdefault key: %@", QTX_AUTORESIGN_USER_DEFAULT_KEY); 
	}
	
	
	
}

@end