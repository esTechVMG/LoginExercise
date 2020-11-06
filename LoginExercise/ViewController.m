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
        
        //Request
        //CODES
        //  -1      Not enough parameters (should not happen as we check for this before doing the request)
        //   1      OK
        //  -2      Invalid Credentials
        
        //Request URL definition
        NSURL * url= [NSURL URLWithString:@"https://qastusoft.com.es/apis/login.php"];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        //Request type
        request.HTTPMethod = @"POST";
        //Request Body
        request.HTTPBody =[[[NSString alloc]initWithFormat:@"user=%@&pass=%@",_userField.text,_passField.text] dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response, NSError * _Nullable error){
            if(error==nil){
                NSHTTPURLResponse * res=(NSHTTPURLResponse *) response;
                if([res statusCode]==200){
                    NSLog(@"HTTP Request Success");
                    NSDictionary * serializedResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    NSNumber * logResNum =[serializedResponse objectForKey:@"code"];
                    int logRes= [logResNum intValue];
                    NSLog(@"Login result: %i",logRes);
                    if(logRes==1){
                        //NSLog(@"Login Successful");
                        UIStoryboard * mainStoryboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        LoggedViewController * viewController= [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginSuccess"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            viewController.nombre=self->_userField.text;
                            [self presentViewController:viewController animated:YES completion:nil];
                        });
                    }else if(logRes==-2){
                        UIAlertController * badPassword = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Contraseña incorrecta" preferredStyle:UIAlertControllerStyleActionSheet];
                            UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                        [badPassword addAction:ok];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self presentViewController:badPassword animated:YES completion:nil];
                        });
                    }else{
                        NSLog(@"Unexpected result in login code");
                    }
                }else{
                    NSLog(@"HTTP Request Failed with status code %li", (long)[res statusCode]);
                }
            }else{
                NSLog(@"Error connecting to server");
            }
            
            /*NSLog(@"COMPLETE RESPONSE: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            //NSLog(@"JSON RESPONSE: %@",serializedResponse);
            NSLog(@"%@",response);
            NSLog(@"ERROR: %@",error);*/
        }];
        [task resume];
        //NSURLSessionDataTask * task = [session dataTaskWithURL:request completionHandler:
        //[task resume];
        //Old password checking
        /*
        NSMutableString * password = [[NSMutableString alloc] initWithString:_userField.text];
        [password appendString:@"."];
        if([password isEqualToString:_passField.text]){
            
        }else{
            
        }
         */
    }
}
@end
