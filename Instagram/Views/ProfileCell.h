//
//  ProfileCell.h
//  Instagram
//
//  Created by Amanda Wang on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end

NS_ASSUME_NONNULL_END
