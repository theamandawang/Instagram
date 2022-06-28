//
//  DetailsViewController.m
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import "DetailsViewController.h"
#import "CommentCell.h"
#import "PostCell.h"
@interface DetailsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.detailsView.post = self.post;
//    [self.detailsView loadValues];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PostCell"];
    [self.tableView setEstimatedRowHeight:200.0];
    [self.tableView reloadData];
    [self.tableView sizeToFit];
    [self.tableView setRowHeight:300.0];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *postCell = nil;
    CommentCell *commentCell = nil;
    if(indexPath.row == 0){
        postCell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
        postCell.detailsView.post = self.post;
        [postCell.detailsView loadValues];
        [self.tableView sizeToFit];

    } else {
        commentCell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        commentCell.commentLabel.text = @"bruh";
        [self.tableView sizeToFit];

    }
    return postCell ? postCell : commentCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

@end
