//
//  HomeViewController.m
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import "Post.h"
#import "DetailsViewController.h"
@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *posts;

@end

@implementation HomeViewController
const int QUERY_SIZE = 20;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PostCell"];
    [self.tableView setEstimatedRowHeight:200.0];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.refreshControl addTarget:self action:@selector(queryData) forControlEvents:UIControlEventValueChanged];
    [self refreshData];

    // Do any additional setup after loading the view.
}
- (void) refreshData {
    [self queryData];
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void) queryData {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = QUERY_SIZE;
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
    [self.refreshControl endRefreshing];

}

- (void) queryAdditionalData:(NSDate *)oldest {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"createdAt" lessThan:oldest];
    query.limit = QUERY_SIZE;
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

- (IBAction)didCompose:(id)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
}
- (IBAction)didLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User signed out successfully");
            SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            sceneDelegate.window.rootViewController = loginViewController;
        }
    }];
    NSLog(@"logging out");
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    if(self.posts){
        Post * temp = self.posts[indexPath.row];
        cell.detailsView.post = temp;
        [cell.detailsView loadValues];
        [self.tableView sizeToFit];
        if(indexPath.row == self.posts.count - 1 && indexPath.row%QUERY_SIZE == 0){
            [self queryAdditionalData:temp.createdAt];
        }
    }
   
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    viewController.post = self.posts[indexPath.row];
    [self.navigationController pushViewController: viewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
