#import "LoggedViewController.h"

@interface LoggedViewController ()

@end

@implementation LoggedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableString * name= [[NSMutableString alloc]initWithString:@"Bienvenido: "];
    [name appendString:_nombre];
    [_welcomeLabel setText:name];
}
@end
