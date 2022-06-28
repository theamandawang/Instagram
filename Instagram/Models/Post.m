//
//  Post.m
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import <Foundation/Foundation.h>
//Post.m
#import "Post.h"
@implementation Post
    
    @dynamic userID;
    @dynamic caption;
    @dynamic image;

    + (nonnull NSString *)parseClassName {
        return @"Post";
    }
    
@end
