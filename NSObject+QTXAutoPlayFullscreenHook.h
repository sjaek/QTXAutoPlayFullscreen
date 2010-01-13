//
//  QTXAutoPlayFullscreenMGDocumentWindowController.h
//  QTXAutoPlayFullscreen
//
//  Created by Marcel Vingerling on 09-10-09.
//  Copyright 2009 Strawberries. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *QTX_AUTOPLAY_USER_DEFAULT_KEY;
extern NSString *QTX_AUTORESIGN_USER_DEFAULT_KEY;

@interface NSObject (QTXAutoPlayFullscreenHook)

- (void) QTXAutoPlayFullscreen_toggleFullScreen:(id)arg1;
- (void) setFullScreen: (BOOL) arg;
@end
