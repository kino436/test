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

    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"Questions" ofType:@"plist"];
    questions = [NSArray arrayWithContentsOfFile:path];

    for(NSDictionary* question in questions) {
        NSLog(@"question:%@", [question objectForKey:@"Question"]);
        NSLog(@"answer:%@", [question objectForKey:@"Answer"]);
    }
    self.question.text = [[questions objectAtIndex:0] objectForKey:@"Question"];
    QuestionCounter = 0;
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
    BOOL SelectedAnswer;
    if (button == self.Button_yes) {
        SelectedAnswer = YES;

//        printf("Inccorect\n");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"結果" message:@"間違いです" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
    } else {
        SelectedAnswer = NO;
        
//        printf("Correct!\n");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"結果" message:@"正解です" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
    }
    if (SelectedAnswer == [[[questions objectAtIndex:QuestionCounter] objectForKey:@"Answer"] boolValue])
    {
                printf("Correct!\n");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"結果" message:@"正解です" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag = YES;
                [alert show];
    } else {
                printf("Inccorect\n");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"結果" message:@"間違いです" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag = NO;
                [alert show];
    }
}

- (void)alertView:(UIAlertView*)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alert.tag == YES)
    {
        if (QuestionCounter == QUESTION_MAX)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"終了" message:@"お疲れ様でした" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag = NO;
            [alert show];
        } else {
            QuestionCounter++;
            self.question.text = [[questions objectAtIndex:QuestionCounter] objectForKey:@"Question"];
        }
    }
}
@end
