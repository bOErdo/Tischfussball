//
//  APPViewController.m
//  Tischfussball
//
//  Created by Ada Möhlmann on 17.01.14.
//  Copyright (c) 2014 Ada Möhlmann. All rights reserved.
//

#import "APPViewController.h"

@interface APPViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeTimeButton;

@end

@implementation APPViewController

int timeTick = 150; // Zehntelsekunden
NSTimer *timer;

- (void) setTimerButtonTitle {
    // Ausgabestring mit Format ss.d erzeugen.
    NSString *TimerValueString = [[NSString alloc] initWithFormat:@"%2.1f", timeTick / 10.0];
    
    self.countDownLabel.text = TimerValueString; // Labeltext setzten.
    
    // Hochfrequentes Setzen des Button Titles führt zur Unsichtbarkeit. :-(
    // [self.timeTimeButton setTitle:TimerValueString forState:UIControlStateNormal];
}

- (IBAction)Start{
    timeTick = 150; // Zehntelsekunden
    
    // Sollte schon ein Timer laufen, so stoppen wir den und legen den nächsten an.
    // Memory Leak? TODO: Investigate
    if (timer != nil) [timer invalidate];
    
    // Neuen Timer erzeugen. Der läuft dann sofort los, bis er ein "invalidate" bekommt.
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self setTimerButtonTitle]; // Anzeige aufdatieren.
}

- (IBAction)Stop:(id)sender {
    // Memory Leak? TODO: Investigate
    if (timer != nil) [timer invalidate];
    timer=nil;
}

-(void) tick {
    timeTick--;
    if (timeTick == 0) {
        [timer invalidate]; // Timer bei "0" Stoppen
        timeTick = 150; // Für den nächsten Lauf schon mal wieder auf 15 Sekunden setzten.
    }

    [self setTimerButtonTitle]; // Anzeige aufdatieren.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setTimerButtonTitle]; // Anzeige aufdatieren.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
