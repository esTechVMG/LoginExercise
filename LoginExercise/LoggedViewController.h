//
//  LoggedViewController.h
//  LoginExercise
//
//  Created by A4-iMAC01 on 28/10/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoggedViewController : UIViewController
@property (nonatomic,assign)NSString * nombre;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@end

NS_ASSUME_NONNULL_END
