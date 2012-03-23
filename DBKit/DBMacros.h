//
//  DBMacros.h
//  DBKit
//
//  Created by David Barry on 11/22/11.
//  Copyright (c) 2011 David Barry. All rights reserved.
//

// This handy macro comes from Wil Shipley, http://www.wilshipley.com/blog/2005/10/pimp-my-code-interlude-free-code.html
static inline BOOL IsEmpty(id thing) {
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

//This debug log macro comes courtesy of Marcus Zarra
#ifdef DEBUG
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLog(...) do { } while (0)
#endif