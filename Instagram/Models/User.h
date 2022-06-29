//
//  User.h
//  Instagram
//
//  Created by Amanda Wang on 6/29/22.
//
#import <UIKit/UIKit.h>

#import "Parse/Parse.h"
@interface User : PFObject<PFSubclassing>

    @property (nonatomic, strong) NSString *userID;
    @property (nonatomic, strong) PFFileObject *image;
    
@end

