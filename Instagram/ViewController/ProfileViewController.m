//
//  ProfileViewController.m
//  Instagram
//
//  Created by Amanda Wang on 6/29/22.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "PostCell.h"
@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (nonatomic) int QUERY_SIZE;
@end

@implementation ProfileViewController
// Not sure why, didn't let me do this because of duplicate symbols?
//const int QUERY_SIZE = 20;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.QUERY_SIZE = 20;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PostCell"];
    [self queryData];
    [self.tableView reloadData];

}
- (void) queryData {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = self.QUERY_SIZE;
    [query whereKey:@"userID" equalTo:[PFUser currentUser].username];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"objectID"];
    [query includeKey:@"userID"];
    [query includeKey:@"image"];
    [query includeKey:@"caption"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = (NSMutableArray *)posts;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void) queryAdditionalData:(NSDate *)oldest {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"createdAt" lessThan:oldest];
    query.limit = self.QUERY_SIZE;
    [query whereKey:@"userID" equalTo:[PFUser currentUser].username];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"objectID"];
    [query includeKey:@"userID"];
    [query includeKey:@"image"];
    [query includeKey:@"caption"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            [self.posts addObjectsFromArray:posts];
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post * temp = self.posts[indexPath.row];
    cell.detailsView.post = temp;
    [cell.detailsView loadValues];
    [self.tableView sizeToFit];
    if(indexPath.row >= self.posts.count - 1){
        [self queryAdditionalData:temp.createdAt];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}
@end
