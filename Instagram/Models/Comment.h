//
//  Comment.h
//  Instagram
//
//  Created by Amanda Wang on 6/29/22.
//
#import <UIKit/UIKit.h>

#import "Parse/Parse.h"
@interface Comment : PFObject<PFSubclassing>

    @property (nonatomic, strong) NSString *userID;
    @property (nonatomic, strong) NSString *text;
    @property (nonatomic, strong) NSDate *createdAt;
    @property (nonatomic, strong) NSString *postID;
    
@end

