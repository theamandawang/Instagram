//
//  DetailsViewController.h
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "DetailsView.h"
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) Post * post;
@end

NS_ASSUME_NONNULL_END
