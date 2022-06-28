//
//  DetailsView.m
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import "DetailsView.h"

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
    [self loadValues];
    return self;
}
- (void) loadValues {
    self.userLabel.text = self.post[@"userID"];
    self.captionLabel.text = self.post[@"caption"];
    self.photoImageView.file = self.post[@"image"];
    [self.photoImageView loadInBackground];
}



@end
