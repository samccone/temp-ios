//
//  tempViewController.m
//  Temp
//
//  Created by Sam Saccone on 12/14/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import "tempViewController.h"

@interface tempViewController ()

@end

@implementation tempViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"24.250.22.134", 3000, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)streamEvent {
    if (streamEvent == NSStreamEventHasBytesAvailable) {
        uint8_t buffer[1024];
        int len;
        
        while ([inputStream hasBytesAvailable]) {
            len = [inputStream read:buffer maxLength:sizeof(buffer)];
            if (len > 0) {
                
                NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                
                if (nil != output) {
                    temp.text = output;
                }
            }
        }
    }
}
@end
