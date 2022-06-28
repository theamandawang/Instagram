//
//  DetailsView.h
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailsView : UIView
@property (strong, nonatomic) Post * post;
@property (strong, nonatomic) IBOutlet UIView *contentView;
- (instancetype) initWithCoder:(NSCoder *)aDecoder;
- (instancetype) initWithFrame:(CGRect)frame;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet PFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
- (instancetype) customInit;
@end

NS_ASSUME_NONNULL_END
