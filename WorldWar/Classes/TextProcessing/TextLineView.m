//
//  TextLineView.m
//  WorldWar
//
//  Created by Dima on 13.04.13.
//
//

#import "TextLineView.h"
#import "Logging.h"
#import "Defs.h"
#import "AppDelegate.h"

#define EMPTY_BUFFER_STRING @"                                     "

@implementation TextLineView
@synthesize textProcessor, realHide;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControls];
    }
    return self;
}

//===================

-(void) initControls {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    textStripBackground = [[UIImageView alloc] initWithFrame:self.bounds];
    [textStripBackground setImage:[UIImage imageNamed:@"TextBackgroundStrip.png"]];
    [self addSubview:textStripBackground];
    
    /*
    CGRect frameForLetterWindow = self.bounds;
    float letterWindowWidth = 30;
    frameForLetterWindow.origin.x = frameForLetterWindow.size.width/2-letterWindowWidth/2;
    frameForLetterWindow.size.width = letterWindowWidth;
    letterWindowImage = [[UIImageView alloc] initWithFrame:frameForLetterWindow];
    [letterWindowImage setImage:[UIImage imageNamed:@"LetterWindow.png"]];
    [self addSubview:letterWindowImage];
    */
    inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(-30, 0, 20, 20)];
    [self addSubview:inputTextField];
    inputTextField.delegate = APP_DELEGATE.textProcessor;
    APP_DELEGATE.textProcessor.textView = self;
    [inputTextField becomeFirstResponder];
    
    textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [textLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:30]];
    //[textLabel setFont:[UIFont fontWithName:@"Avenir-Book" size:30]];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:textLabel];
    [self setText:[APP_DELEGATE.textProcessor levelText]];
    [self highlightNormalChar];
    highlightedLetterRange = NSMakeRange(highlightedLetterNumber, 1);
}

//===================

-(void) setText:(NSString*) text{
    bookString = [[NSMutableAttributedString alloc] initWithString:text];
    [bookString replaceCharactersInRange:NSMakeRange(0, 0) withAttributedString:[[NSAttributedString alloc] initWithString:EMPTY_BUFFER_STRING]];
    [bookString setAttributes:[self stringAttributes] range:highlightedLetterRange];
    [textLabel setAttributedText:bookString];
}

//===================

-(void) moveLetters{
    int lettersCount = 1;
    NSArray *atributes = [[self stringAttributes] allKeys];
    for (NSString *key in atributes){
        [bookString removeAttribute:key range:highlightedLetterRange];
    }
    [bookString deleteCharactersInRange:NSMakeRange(0, lettersCount)];
    [bookString setAttributes:[self stringAttributes] range:highlightedLetterRange];
    [textLabel setAttributedText:bookString];
}

//===================

-(NSDictionary*) stringAttributes{
    NSDictionary* result = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30],
                             NSBackgroundColorAttributeName: [UIColor yellowColor]};
    return  result;
}

//===================

-(NSString*)currentLetter{
    return [[bookString string] substringWithRange:highlightedLetterRange];
}

//===================

-(void) highlightNormalChar{
    [bookString setAttributes:[self stringAttributes] range:highlightedLetterRange];
    [textLabel setAttributedText:bookString];
}

//===================

-(void) highlightWrongChar{
    [bookString addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:highlightedLetterRange];
    [textLabel setAttributedText:bookString];
    [self performSelector:@selector(highlightNormalChar) withObject:nil afterDelay:0.2];
}

//===================

-(int) charsLeft{
    return bookString.length;
}

//===================

- (void)keyboardDidHide:(id)sender
{
    if (!self.realHide){
        [inputTextField becomeFirstResponder];
    }
}

//===================

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

//===================

@end
