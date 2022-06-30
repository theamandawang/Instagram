//
//  DetailsView.m
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import "DetailsView.h"
#import "User.h"
@implementation DetailsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self customInit];
    }
    return self;
}
- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self customInit];
    }
    return self;
}
- (instancetype) customInit{
    [[NSBundle mainBundle] loadNibNamed: @"DetailsView" owner: self options:nil];
    [self addSubview: self.contentView];
    self.contentView.frame = self.bounds;
    return self;
}
- (void) getUserPFP {
    PFQuery *query = [PFUser query];
    query.limit = 1;

    [query whereKey:@"username" equalTo:self.post[@"userID"]];
    [query includeKey:@"image"];
    [query findObjectsInBackgroundWithBlock:^(NSArray<User *> *users, NSError * _Nullable error) {
        if(error){
            NSLog(@"🤬🤬🤬🤬 request return nothing!");
        } else {
            if(users && users.count > 0){
                NSLog(@"🥶🥶🥶 YASSS!");
                self.profileImageView.file = users[0].image;
                [self.profileImageView loadInBackground];
            }
        }
    }];
}
- (void) loadValues {
    self.userLabel.text = self.post[@"userID"];
    self.captionLabel.text = self.post[@"caption"];
    self.photoImageView.file = self.post[@"image"];
    [self.photoImageView loadInBackground];
    
    //NOT SURE WHY THIS HAS TO BE PFUSER QUERY
    [self getUserPFP];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a MMM d, yyyy"];
    self.createdAtLabel.text =  [formatter stringFromDate: self.post.createdAt];
//    [self.dateLabelTopToCaptionLabelBottom setActive:false];
//    [self.dateLabelBottomToSafeView setActive:false];
//    [self.captionLabelBottomToSafeView setActive:true];
    [self.createdAtLabel setHidden:true];

}
- (void) showDate {
//    [self.captionLabelBottomToSafeView setActive:false];
//    [self.dateLabelTopToCaptionLabelBottom setActive:true];
//    [self.dateLabelBottomToSafeView setActive:true];

    [self.createdAtLabel setHidden:false];
}



@end
