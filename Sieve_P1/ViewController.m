//
//  ViewController.m
//  Sieve_P1
//
//  Created by Jordan Sieve on 9/22/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "ViewController.h"
#import "StopWatchTimerModel.h"

@interface ViewController () <MainTimerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *TimerLapsTableView;
@property (nonatomic, weak) IBOutlet UIButton *startStopTimerButton;
@property (nonatomic, weak) IBOutlet UIButton *resetLapTimerButton;
@property (nonatomic, weak) IBOutlet UILabel *mainTimerLabel;
@property (nonatomic, weak) IBOutlet UILabel *lapTimerLabel;
@property (nonatomic, strong) StopWatchTimerModel *model;
@property (nonatomic) int timerCounterMod;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up for delegate
    _model = [[StopWatchTimerModel alloc] init];
    [_model setDelegate:self];
    
    // Set values to variables used
    _timerCounterMod = 0;
    _model.lapTimerArrayExist = NO;
    
    // Set up for table view
    [self.TimerLapsTableView setDelegate:self];
    [self.TimerLapsTableView setDataSource:self];
    
    // Shape buttons for roundy-ness
    self.startStopTimerButton.layer.cornerRadius = 37;
    self.resetLapTimerButton.layer.cornerRadius = 37;
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.lapTimerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LapTime" forIndexPath:indexPath];
    cell.textLabel.text = [[[self model] lapTimerArray] objectAtIndex:[indexPath row]];

    return cell;
}

#pragma mark - Button Pressed Methods

- (IBAction)startStopButtonPressed:(id)sender {
    _timerCounterMod++;
    // Use modulus math to determine Start/Stop switchover
    if (_timerCounterMod % 2) {
        // Change buttons design/colors around and start timers
        [_startStopTimerButton setTitle: @"Stop" forState: UIControlStateNormal];
        [_startStopTimerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_resetLapTimerButton setTitle: @"Lap" forState: UIControlStateNormal];
        [_resetLapTimerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_model startMainTimer];
        [_model startLapTimer];
    }
    else {
        // change buttons design/colors back to original and stop timer
        [_startStopTimerButton setTitle: @"Start" forState: UIControlStateNormal];
        [_startStopTimerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetLapTimerButton setTitle: @"Reset" forState: UIControlStateNormal];
        [_resetLapTimerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_model stopTimer];
    }
}

- (IBAction)resetLapButtonPressed:(id)sender {
    // Use modulus math to determine Reset/Lap switchover
    if (_timerCounterMod % 2) {
        [_model restartLapTimer];
        [_model startLapTimer];
    }
    else {
        [_model resetLapTimer];
        self.mainTimerLabel.text = @"00:00.00";
        self.lapTimerLabel.text = @"Lap 00:00.00";
    }
    
    // Reload the data to populate the Table View
    [_TimerLapsTableView reloadData];
}

#pragma mark - StopWatchTimerModel Delegate Methods

- (void)lapTimerUpdateLabelWithString:(NSString *) lapTimerUpdate
{
    // Update lap label text
    self.lapTimerLabel.text = lapTimerUpdate;
}
    
- (void)mainTimerUpdateLabelWithString:(NSString *) mainTimerUpdate
{
    // Update main label text
    self.mainTimerLabel.text = mainTimerUpdate;
}

@end
