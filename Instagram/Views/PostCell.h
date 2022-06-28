//
//  PostCell.h
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "DetailsView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet DetailsView *detailsView;

@end

NS_ASSUME_NONNULL_END
