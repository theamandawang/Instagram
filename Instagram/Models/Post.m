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
    @dynamic createdAt;
    + (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
        // check if image is not nil
        if (!image) {
            return nil;
        }
        NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
        // get image data and check if that is not nil
        if (!imageData) {
            return nil;
        }
        return [PFFileObject fileObjectWithName:@"image.jpeg" data:imageData];
    }
    + (nonnull NSString *)parseClassName {
        return @"Post";
    }
    
@end
