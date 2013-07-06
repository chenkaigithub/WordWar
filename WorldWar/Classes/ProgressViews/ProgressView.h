//
//  ProgressView.h
//  WorldWar
//
//  Created by Dima on 14.04.13.
//
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView {
    UIImageView *leftBorder;
    UIImageView *rightBorder;
    UIImageView *middleConnector;
    UIImageView *progressBar;
    UILabel *sideLabel;
    
    int progress;
}

-(void) setProgressPercentage:(int)progress;
-(void) setSideText:(NSString*) sideText;
-(int) progress;
@end
