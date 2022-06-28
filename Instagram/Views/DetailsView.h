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
- (instancetype) initWithCoder:(NSCoder *)aDecoder;
- (instancetype) initWithFrame:(CGRect)frame;
- (instancetype) customInit;
@property (strong, nonatomic) Post * post;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet PFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
- (void) loadValues;
@end

NS_ASSUME_NONNULL_END
