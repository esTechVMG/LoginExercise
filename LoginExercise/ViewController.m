//
//  ViewController.m
//  LoginExercise
//
//  Created by A4-iMAC01 on 21/10/2020.
//

#import "ViewController.h"
#import "LoggedViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Atencion" message:@"¿Es usted alumno de DAM o alumno de VJ?" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * damAction = [UIAlertAction actionWithTitle:@"DAM" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self.titulo setText:@"Soy alumno de DAM"];
        }];
        UIAlertAction * vjAction = [UIAlertAction actionWithTitle:@"VJ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self.titulo setText: @"Soy alumno de VJ"];
    }];
    [alert addAction:damAction];
    [alert addAction:vjAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)loginBtnPressed:(id)sender {
    if([_passField.text isEqualToString:@""]|[_userField.text isEqualToString:@""]){
        UIAlertController * nothingAlert = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Rellene todo los campos, por favor" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [nothingAlert addAction:ok];
        [self presentViewController:nothingAlert animated:YES completion:nil];
    }else if([_passField.text length]<6|[_userField.text length]<6){
        UIAlertController * insufficientLenghtAlert = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Su nombre de usuario y contraseña deben ser de al menos 6 caracteres" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [insufficientLenghtAlert addAction:ok];
        [self presentViewController:insufficientLenghtAlert animated:YES completion:nil];
    }else{
        NSMutableString * password = [[NSMutableString alloc] initWithString:_userField.text];
        [password appendString:@"."];
        if([password isEqualToString:_passField.text]){
            //NSLog(@"Login Successful");
            UIStoryboard * mainStoryboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoggedViewController * viewController= [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginSuccess"];
            viewController.nombre=_userField.text;
            [self presentViewController:viewController animated:YES completion:nil];
        }else{
            UIAlertController * badPassword = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Contraseña incorrecta" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [badPassword addAction:ok];
            [self presentViewController:badPassword animated:YES completion:nil];
        }
    }
}

@end
