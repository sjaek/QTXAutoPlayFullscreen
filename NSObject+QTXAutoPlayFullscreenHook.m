//
//  QTXAutoPlayFullscreenMGDocumentWindowController.m
//  QTXAutoPlayFullscreen
//
//  Created by Marcel Vingerling on 09-10-09.
//  Copyright 2009 Strawberries. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NSObject+QTXAutoPlayFullscreenHook.h"
#import <QTKit/QTKit.h>


NSString *QTX_AUTOPLAY_USER_DEFAULT_KEY = @"QTXAutoPlayFullscreenEnabled";
NSString *QTX_AUTORESIGN_USER_DEFAULT_KEY = @"QTXAutoResignFullscreenEnabled";

@implementation NSObject (QTXAutoPlayFullscreenHook)

- (void) QTXAutoPlayFullscreen_dealloc {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:QTX_AUTORESIGN_USER_DEFAULT_KEY]) {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:QTMovieDidEndNotification object:[[self performSelector:@selector(document)] performSelector:@selector(movie)]];
	}
	// will call the swizzled method after bundle has loaded.
	[self QTXAutoPlayFullscreen_dealloc];
}

- (void) QTXAutoPlayFullscreen_toggleFullScreen:(id)arg1
{
	// will call the swizzled method after bundle has loaded.
	[self QTXAutoPlayFullscreen_toggleFullScreen:arg1];
	
	[self performSelectorInBackground:@selector(QTXAutoPlayFullscreen_handleautoplay) withObject:self];
}

- (void) QTXAutoPlayFullscreen_resignFullscreen: (NSNotification *)notification
{
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:QTX_AUTORESIGN_USER_DEFAULT_KEY]) {
		// will call overridden method 
		[self setFullScreen: NO];		
		[[NSNotificationCenter defaultCenter] removeObserver:self 
														name:QTMovieDidEndNotification 
													  object:[[self performSelector:@selector(document)] performSelector:@selector(movie)]];
	}
	
}

- (void) setFullScreen: (BOOL) arg
{
	// do nothing
	NSLog(@"Should never be called");
}

- (void) QTXAutoPlayFullscreen_handleautoplay {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	if ([[NSUserDefaults standardUserDefaults] boolForKey:QTX_AUTOPLAY_USER_DEFAULT_KEY] && [self performSelector:@selector(isFullScreen)]) {
		id document = [self performSelector:@selector(document)];
		QTMovie *movie = [document performSelector:@selector(movie)];
		float rate = [movie rate];
		if (rate == 0.0) {
			[movie performSelector:@selector(autoplay)];
		}
		if ([[NSUserDefaults standardUserDefaults] boolForKey:QTX_AUTORESIGN_USER_DEFAULT_KEY]) {
			
			[[NSNotificationCenter defaultCenter] addObserver:self 
													 selector: @selector(QTXAutoPlayFullscreen_resignFullscreen:) 
														 name:QTMovieDidEndNotification 
													   object:[[self performSelector:@selector(document)] performSelector:@selector(movie)]];
		}
	} 
	[pool release];
}


@end