//
//  ViewController.h
//  test
//
//  Created by 鈴木正人 on 2014/01/04.
//  Copyright (c) 2014年 鈴木正人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSArray* questions;
    unsigned short QuestionCounter;
}
@property (weak, nonatomic) IBOutlet UIButton *Button_yes;
@property (weak, nonatomic) IBOutlet UIButton *Button_no;
@property (weak, nonatomic) IBOutlet UILabel *question;

@end
