//
//  Comment.m
//  Instagram
//
//  Created by Amanda Wang on 6/29/22.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
@implementation Comment
    @dynamic userID;
    @dynamic text;
    @dynamic createdAt;
    @dynamic postID;
    + (nonnull NSString *)parseClassName {
        return @"Comment";
    }
    
@end
