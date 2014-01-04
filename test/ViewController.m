//
//  ViewController.m
//  test
//
//  Created by 鈴木正人 on 2014/01/04.
//  Copyright (c) 2014年 鈴木正人. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.Button_yes addTarget:self action:@selector(showResult:) forControlEvents:UIControlEventTouchDown];
    [self.Button_no addTarget:self action:@selector(showResult:) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showResultIncorrect
{
    printf("Incorrect\n");
}

- (void)showResultCorrect
{
    printf("Correct\n");
}

- (void)showResult:(UIButton*)button
{
    if (button == self.Button_yes) {
        printf("Inccorect\n");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"結果" message:@"間違いです" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        printf("Correct!\n");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"結果" message:@"正解です" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
@end
