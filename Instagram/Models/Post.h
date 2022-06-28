//
//  Post.h
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//
#import <UIKit/UIKit.h>

#import "Parse/Parse.h"
@interface Post : PFObject<PFSubclassing>

    @property (nonatomic, strong) NSString *userID;
    @property (nonatomic, strong) NSString *caption;
    @property (nonatomic, strong) PFFileObject *image;
    
@end

