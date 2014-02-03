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
    unsigned short QuestionsMax;
}
@property (weak, nonatomic) IBOutlet UIButton *Button_option1;
@property (weak, nonatomic) IBOutlet UIButton *Button_option2;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (nonatomic, assign) BOOL finished;
@property (weak, nonatomic) IBOutlet UIButton *option1;
@property (weak, nonatomic) IBOutlet UIButton *option2;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
