//
//  TextLineView.h
//  WorldWar
//
//  Created by Dima on 13.04.13.
//
//

#import <UIKit/UIKit.h>

@interface TextLineView : UIView {
    
    UIImageView *textStripBackground;
    UIImageView *letterWindowImage;
    UITextField *inputTextField;
    
    UILabel *textLabel;
    
    NSMutableAttributedString *bookString;
    NSRange highlightedLetterRange;
}
@property (nonatomic,assign) BOOL realHide;
@property (nonatomic,assign) id <UITextFieldDelegate> textProcessor;

-(void) moveLetters;
-(NSString*)currentLetter;
-(void) highlightWrongChar;
-(void) highlightNormalChar;
-(int) charsLeft;



@end
