/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "RCTLog.h"
#import "RCTRootView.h"

#define TIMEOUT_SECONDS 240
#define TEXT_TO_LOOK_FOR @"Welcome to React Native!"

@interface MathFactsTests : XCTestCase

@end

@implementation MathFactsTests


- (BOOL)findSubviewInView:(UIView *)view matching:(BOOL(^)(UIView *view))test
{
  if (test(view)) {
    return YES;
  }
  for (UIView *subview in [view subviews]) {
    if ([self findSubviewInView:subview matching:test]) {
      return YES;
    }
  }
  return NO;
}

- (void)testRendersWelcomeScreen {
  UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
  NSDate *date = [NSDate dateWithTimeIntervalSinceNow:TIMEOUT_SECONDS];
  BOOL foundElement = NO;

  __block NSString *redboxError = nil;
  RCTSetLogFunction(^(RCTLogLevel level, NSString *fileName, NSNumber *lineNumber, NSString *message) {
    if (level >= RCTLogLevelError) {
      redboxError = message;
    }
  });
  
  while ([date timeIntervalSinceNow] > 0 && !foundElement && !redboxError) {
    [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode beforeDate:date];
    [[NSRunLoop mainRunLoop] runMode:NSRunLoopCommonModes beforeDate:date];

    foundElement = [self findSubviewInView:vc.view matching:^BOOL(UIView *view) {
      if ([view.accessibilityLabel isEqualToString:TEXT_TO_LOOK_FOR]) {
        return YES;
      }
      return NO;
    }];
  }

  XCTAssertNil(redboxError, @"RedBox error: %@", redboxError);
  XCTAssertTrue(foundElement, @"Cound't find element with text '%@' in %d seconds", TEXT_TO_LOOK_FOR, TIMEOUT_SECONDS);
}


@end
