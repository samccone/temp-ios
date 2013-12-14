//
//  tempViewController.h
//  Temp
//
//  Created by Sam Saccone on 12/14/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import <UIKit/UIKit.h>

NSInputStream *inputStream;
NSOutputStream *outputStream;

@interface tempViewController : UIViewController <NSStreamDelegate> {
    IBOutlet UILabel *temp;
}

@end
