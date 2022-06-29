//
//  LoginViewController.m
//  Instagram
//
//  Created by Amanda Wang on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@end

@implementation LoginViewController
- (bool)checkEmpty {
    if([self.userTextField.text isEqual:@""] || [self.passTextField isEqual:@""]){
        UIAlertController *alert =
            [UIAlertController
                        alertControllerWithTitle:@"Empty username or password"
                        message:@"Username and password fields cannot be empty."
                        preferredStyle:(UIAlertControllerStyleAlert)
            ];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle cancel response here. Doing nothing will dismiss the view.
                                                          }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        return true;
    }
    return false;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didLogin:(id)sender {
    if(![self checkEmpty]){
        [PFUser logInWithUsernameInBackground:self.userTextField.text password:self.passTextField.text
         block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                
                // display view controller that needs to shown after successful login
//                [self performSegueWithIdentifier:@"authenticatedSegue" sender:nil];
                SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UITabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                sceneDelegate.window.rootViewController = tabBarController;
            }
        }];
        
    }
    
}
- (IBAction)didSignUp:(id)sender {
    if(![self checkEmpty]){
        PFUser *newUser = [PFUser user];
            
            // set user properties
            newUser.username = self.userTextField.text;
            newUser.password = self.passTextField.text;
            
            // call sign up function on the object
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
                if (error != nil) {
                    NSLog(@"Error: %@", error.localizedDescription);
                } else {
                    NSLog(@"User registered successfully");
//                    [self performSegueWithIdentifier:@"authenticatedSegue" sender:nil];
                    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UITabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                    sceneDelegate.window.rootViewController = tabBarController;
                    // manually segue to logged in view
                }
        }];
    }
}
- (IBAction)didTap:(id)sender {
    [self.view endEditing:true];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
