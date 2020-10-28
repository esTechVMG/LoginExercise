//
//  LoggedViewController.m
//  LoginExercise
//
//  Created by A4-iMAC01 on 28/10/2020.
//

#import "LoggedViewController.h"

@interface LoggedViewController ()

@end

@implementation LoggedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableString * name= [[NSMutableString alloc]initWithString:@"Bienvenido: "];
    [name appendString:_nombre];
    [_welcomeLabel setText:name];
    
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

@end
