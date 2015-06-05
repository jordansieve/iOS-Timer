//
//  StopWatchTimerModel.h
//  Sieve_P1
//
//  Created by Jordan Sieve on 9/24/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Delegate Methods

@protocol MainTimerDelegate <NSObject>

- (void)lapTimerUpdateLabelWithString:(NSString *) lapTimerUpdate;
- (void)mainTimerUpdateLabelWithString:(NSString *) mainTimerUpdate;

@end


#pragma mark - Model Public Variables/Methods

@interface StopWatchTimerModel : NSObject

@property (nonatomic) BOOL lapTimerArrayExist;
@property (nonatomic, strong) NSMutableArray *lapTimerArray;
@property (nonatomic, weak) id<MainTimerDelegate> delegate;
- (void)startMainTimer;
- (void)startLapTimer;
- (void)stopTimer;
- (void)restartLapTimer;
- (void)resetLapTimer;

@end
