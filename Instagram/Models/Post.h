//
//  Post.h
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//
#import <UIKit/UIKit.h>

#import "Parse/Parse.h"
@interface Post : PFObject<PFSubclassing>
+ (PFFileObject *_Nullable)getPFFileFromImage: (UIImage * _Nullable)image;

@property (nonatomic, strong) NSString * _Nullable userID;
@property (nonatomic, strong) NSString * _Nullable caption;
@property (nonatomic, strong) NSDate * _Nullable createdAt;
@property (nonatomic, strong) PFFileObject * _Nullable image;
    
@end

