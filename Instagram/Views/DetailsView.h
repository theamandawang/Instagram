//
//  DetailsView.h
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
- (instancetype) initWithCoder:(NSCoder *)aDecoder;
- (instancetype) initWithFrame:(CGRect)frame;
- (instancetype) customInit;
@end

NS_ASSUME_NONNULL_END
