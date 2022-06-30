//
//  User.h
//  Instagram
//
//  Created by Amanda Wang on 6/29/22.
//
#import <UIKit/UIKit.h>

#import "Parse/Parse.h"
@interface User : PFUser

    @property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
    @property (nonatomic, strong) PFFileObject *image;
    
@end

