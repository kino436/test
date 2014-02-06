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
    
    /*
     ボタンに処理を紐付ける
     */
    [self.Button_option1 addTarget:self action:@selector(processAnswer:) forControlEvents:UIControlEventTouchDown];
    [self.Button_option2 addTarget:self action:@selector(processAnswer:) forControlEvents:UIControlEventTouchDown];

    /*
     クイズデータを読み込む
     */
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"Questions" ofType:@"plist"];
    questions = [NSArray arrayWithContentsOfFile:path];
    QuestionsMax = questions.count;

    /*
     Console Output For Debug
     */
    for(NSDictionary* question in questions) {
        NSLog(@"question:%@", [question objectForKey:@"Question"]);
        NSLog(@"answer:%@", [question objectForKey:@"CorrectAnswer"]);
        NSLog(@"incorrect answer:%@", [question objectForKey:@"IncorrectAnswer"]);
        NSLog(@"backgroundImage:%@", [question objectForKey:@"backgroundImage"]);
    }
    /*
     乱数初期化
     */
    srand(time(nil));
    
    /*
     BGMを再生する
     */
    [self playBgmRoop];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    /*
     ULlabelを複数行表示できるように設定する
     */
    self.question.lineBreakMode = NSLineBreakByWordWrapping;

    /*
     第1問を表示する
     */
    QuestionCounter = 0;
    [self displayRandomQuestionAndAnswer];
    
    [self.view layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 回答を処理する
 */
- (void)processAnswer:(UIButton*)button
{
    NSString *SelectedAnswer;
    if (button == self.Button_option1) {
        SelectedAnswer = self.Button_option1.currentTitle;
    } else {
        SelectedAnswer = self.Button_option2.currentTitle;
    }
    
    [self showRelsult:SelectedAnswer];
    [self showFinishMessage];
}

/*
 最後の問題でなければ次の問題文を表示する
 */
- (void)alertView:(UIAlertView*)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (QuestionCounter <= QuestionsMax - 1)
        {
            [self displayRandomQuestionAndAnswer];
        }
    self.finished = YES;
}

/*
 結果を表示する
 */
- (void)showRelsult:(NSString *)SelectedAnswer
{
    if (YES == [SelectedAnswer isEqualToString:[[questions objectAtIndex:QuestionCounter] objectForKey:@"CorrectAnswer"]])
    {
        printf("Correct!\n");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"結果" message:@"正解です" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = YES;
        [alert show];
        QuestionCounter++;
    } else {
        printf("Inccorect\n");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"結果" message:@"間違いです" delegate:self cancelButtonTitle:@"やり直す" otherButtonTitles: nil];
        alert.tag = NO;
        [alert show];
    }
    self.finished = NO;
}

/*
 終了であれば終了メッセージを表示する
 */
- (void)showFinishMessage
{
    // アラートビューのクラッシュ対策
    while (!self.finished) {
        [[NSRunLoop currentRunLoop]
         runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
    if (QuestionCounter == QuestionsMax)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"終了" message:@"お疲れ様でした" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = NO;
        [alert show];
    }
}

/*
 質問と画像と回答を表示する
 */
- (void)displayRandomQuestionAndAnswer
{
    /*
     質問の表示
     */
    self.question.text = [[questions objectAtIndex:QuestionCounter] objectForKey:@"Question"];
    self.question.numberOfLines = 0;
    [self.question sizeToFit];
    
    /*
     画像の表示
     */
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[[questions objectAtIndex: QuestionCounter] objectForKey:@"backgroundImage"]]];
    [_backgroundImageView setImage:img];

    /*
     ランダムな回答の表示
     */
    if (0 == rand()%2) {
        [self.Button_option1 setTitle:[[questions objectAtIndex:QuestionCounter] objectForKey:@"CorrectAnswer"] forState:UIControlStateNormal];
        [self.Button_option2 setTitle:[[questions objectAtIndex:QuestionCounter] objectForKey:@"IncorrectAnswer"] forState:UIControlStateNormal];
        NSLog(@"True Answer=option1");
    } else {
        [self.Button_option1 setTitle:[[questions objectAtIndex:QuestionCounter] objectForKey:@"IncorrectAnswer"] forState:UIControlStateNormal];
        [self.Button_option2 setTitle:[[questions objectAtIndex:QuestionCounter] objectForKey:@"CorrectAnswer"] forState:UIControlStateNormal];
        NSLog(@"True Answer=option2");
    }
}

/*
 BGMを再生する
 */
- (void)playBgmRoop
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aikatsu" ofType:@"mp3"];
    if (path == nil) {
        NSLog(@"ファイルが見つかりません");
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];

    // 無限ループ
    audio.numberOfLoops = -1;
    
    [audio play];
}
@end
