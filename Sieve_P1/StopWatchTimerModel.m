//
//  StopWatchTimerModel.m
//  Sieve_P1
//
//  Created by Jordan Sieve on 9/24/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "StopWatchTimerModel.h"

#pragma mark - Private Model Properties

@interface StopWatchTimerModel()

@property (nonatomic, strong) NSTimer *mainTimer;
@property (nonatomic, strong) NSTimer *lapTimer;
@property (nonatomic) int privateCurrentLapTimerHundredthsCount;
@property (nonatomic) int privateCurrentMainTimerHundredthsCount;
@property (nonatomic) int privateCurrentLapTimerSecondsCount;
@property (nonatomic) int privateCurrentMainTimerSecondsCount;
@property (nonatomic) int privateCurrentLapTimerMinutesCount;
@property (nonatomic) int privateCurrentMainTimerMinutesCount;
@property (nonatomic) int lapCounter;
@property (nonatomic, weak) NSString *privateFormattedLapTimerString;
@property (nonatomic, weak) NSString *privateFormattedMainTimerString;

@end


@implementation StopWatchTimerModel

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - Main / Lap Timer Starting Methods

- (void)startMainTimer
{
    // Test to see if array exists already
    if (_lapTimerArrayExist == NO) {
        _lapTimerArray = [[NSMutableArray alloc] init];
        _lapTimerArrayExist = YES;
    }
    
    // Start main timer
    _mainTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(mainTimerStarted) userInfo:nil repeats:YES];
}

- (void)mainTimerStarted
{
    // Do correct math to fill in time spaces in Main label
    _privateCurrentMainTimerHundredthsCount++;
    if (_privateCurrentMainTimerHundredthsCount >= 100) {
        _privateCurrentMainTimerHundredthsCount = 0;
        _privateCurrentMainTimerSecondsCount++;
        if (_privateCurrentMainTimerSecondsCount >= 60) {
            _privateCurrentMainTimerSecondsCount = 0;
            _privateCurrentMainTimerMinutesCount++;
        }
    }
    
    // Format the string and send the information over a delegate
    _privateFormattedMainTimerString = [NSString stringWithFormat:@"%02d:%02d.%02d", _privateCurrentMainTimerMinutesCount, _privateCurrentMainTimerSecondsCount, _privateCurrentMainTimerHundredthsCount];
    [self.delegate mainTimerUpdateLabelWithString: _privateFormattedMainTimerString];
}

- (void)startLapTimer
{
    // Test to see if array exists already
    if (_lapTimerArrayExist == NO) {
        _lapTimerArray = [[NSMutableArray alloc] init];
        _lapTimerArrayExist = YES;
    }
    
    // Track number of laps for table view
    _lapCounter++;
    
    // Start lap timer
    _lapTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(lapTimerStarted) userInfo:nil repeats:YES];
}


- (void)lapTimerStarted
{
    // Do correct math to fill in time spaces in Lap label
    _privateCurrentLapTimerHundredthsCount++;
    if (_privateCurrentLapTimerHundredthsCount >= 100) {
        _privateCurrentLapTimerHundredthsCount = 0;
        _privateCurrentLapTimerSecondsCount++;
        if (_privateCurrentLapTimerSecondsCount >= 60 ) {
            _privateCurrentLapTimerSecondsCount = 0;
            _privateCurrentLapTimerMinutesCount++;
        }
    }
    
    // Format the string and send the information over a delegate
    _privateFormattedLapTimerString = [NSString stringWithFormat:@"Lap %02d:%02d.%02d", _privateCurrentLapTimerMinutesCount, _privateCurrentLapTimerSecondsCount, _privateCurrentLapTimerHundredthsCount];
    [self.delegate lapTimerUpdateLabelWithString: _privateFormattedLapTimerString];
}


#pragma mark - Stop / Reset / Restart Timer Methods

- (void) stopTimer
{
    // Keep lap timer accurate
    _lapCounter--;
    
    // Pause both timers when stop button is pressed
    [_mainTimer invalidate];
    [_lapTimer invalidate];
}

- (void) resetLapTimer
{
    // Reset button clears all values and lap array
    _privateCurrentLapTimerMinutesCount = 0;
    _privateCurrentLapTimerSecondsCount = 0;
    _privateCurrentLapTimerHundredthsCount = 0;
    _privateCurrentMainTimerMinutesCount = 0;
    _privateCurrentMainTimerSecondsCount = 0;
    _privateCurrentMainTimerHundredthsCount = 0;
    [_lapTimerArray removeAllObjects];
    _lapCounter = 0;
}

- (void) restartLapTimer
{
    // Add the current lap to the array before restarting
    [_lapTimerArray insertObject: [NSString stringWithFormat: @"Lap %d %02d:%02d.%02d", _lapCounter, _privateCurrentLapTimerMinutesCount, _privateCurrentLapTimerSecondsCount, _privateCurrentLapTimerHundredthsCount] atIndex:0];
    
    // Stop the current timer
    [_lapTimer invalidate];
    
    // Clear out timer variables
    _privateCurrentLapTimerHundredthsCount = 0;
    _privateCurrentLapTimerMinutesCount = 0;
    _privateCurrentLapTimerSecondsCount = 0;
}

@end
