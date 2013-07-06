//
//  ProgressView.m
//  WorldWar
//
//  Created by Dima on 14.04.13.
//
//

#import "ProgressView.h"
#define  labelWidth 100
@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControls];
    }
    return self;
}

-(void) initControls{
    progress = 0;
    /*leftBorder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, self.frame.size.height)];
    [leftBorder setImage:[UIImage imageNamed:@"progressBarLeftBorder.png"]];
    [self addSubview:leftBorder];
    
    rightBorder = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-10, 0, 10, self.frame.size.height)];
    [rightBorder setImage:[UIImage imageNamed:@"progressBarRightBorder.png"]];
    [self addSubview:rightBorder];
    
    middleConnector = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width-10, self.frame.size.height)];
    [middleConnector setImage:[UIImage imageNamed:@"progressBarRightBorder.png"]];
    [self addSubview:middleConnector];
    */
    
    progressBar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, self.frame.size.width-10, self.frame.size.height-4)];
    [progressBar setImage:[UIImage imageNamed:@"progressBarFillBar.png"]];
    [self addSubview:progressBar];
    
    sideLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-labelWidth/2, 2, labelWidth, self.frame.size.height-4)];
    [sideLabel setBackgroundColor:[UIColor clearColor]];
    [sideLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [sideLabel setTextColor:[UIColor redColor]];
    [sideLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:sideLabel];
}

-(void) setProgressPercentage:(int)_progress{
    progress = _progress;
   // CGRect frameForBar = CGRectMake(5, 2, (self.frame.size.width-10)*_progress, self.frame.size.height-4);
   // progressBar.frame = frameForBar;
}

-(void) setSideText:(NSString*) sideText{
    NSLog(@"%@",sideText);
    [sideLabel setText: sideText];
}

-(int) progress {
    return progress;
}

@end
