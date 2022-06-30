//
//  ProfileViewController.m
//  Instagram
//
//  Created by Amanda Wang on 6/29/22.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "User.h"
#import "PostCell.h"
#import "ProfileCell.h"
#import "Parse/PFImageView.h"
@interface ProfileViewController () <UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource>
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
    PostCell *postCell = nil;
    ProfileCell *profileCell = nil;
    if(indexPath.row == 0){
        profileCell = [self.tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
        profileCell.profileImageView.file =  [PFUser currentUser][@"image"];
        profileCell.profileImageView.layer.cornerRadius = profileCell.profileImageView.frame.size.width/2;
        profileCell.profileImageView.layer.masksToBounds = YES;
        [profileCell.profileImageView loadInBackground];
        profileCell.userLabel.text = [PFUser currentUser].username;
    } else {
        postCell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
        Post * temp = self.posts[indexPath.row - 1];
        postCell.detailsView.post = temp;
        [postCell.detailsView loadValues];
        [postCell.detailsView showDate];
        [self.tableView sizeToFit];
        if(indexPath.row >= self.posts.count){
            [self queryAdditionalData:temp.createdAt];
        }

    }
    return postCell ? postCell : profileCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count + 1;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    // Dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    PFFileObject * obj = [Post getPFFileFromImage: originalImage];
    [[PFUser currentUser] setObject:obj forKey:@"image"];
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL success, NSError * _Nullable error) {
        if(success){
            NSLog(@"YASSS");
            [self.tableView reloadData];
        } else {
            NSLog(@"🤬🤬🤬🤬🤬🤬");
        }
    }];
    
}

- (IBAction)didTapProfileImage:(id)sender {
    UIAlertController *alert =
        [UIAlertController
                    alertControllerWithTitle:@"Upload Photo or Take Photo"
                    message:@"Would you like to upload a photo from your photos library or take one with your camera?"
                    preferredStyle:(UIAlertControllerStyleAlert)
        ];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * _Nonnull action) {
                                        // handle cancel response here. Doing nothing will dismiss the view.
                                    }];
    [alert addAction:cancelAction];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Use Camera"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
                                                      }];
    [alert addAction:cameraAction];
    UIAlertAction *libraryAction = [UIAlertAction
                                    actionWithTitle:@"Use Library"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * _Nonnull action) {
                                        [self openLibrary];
                                    }];
    [alert addAction:libraryAction];
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}
- (void) openCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        [self openLibrary];
        return;
    }
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}
- (void) openLibrary {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
@end
