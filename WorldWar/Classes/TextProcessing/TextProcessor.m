//
//  TextProcessor.m
//  WorldWar
//
//  Created by Dima on 13.04.13.
//
//

#import "TextProcessor.h"
#import "Logging.h"

@implementation TextProcessor
@synthesize textView;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        [self initItems];
    }
    return self;
}


-(void) initItems{
    lettersTappedRight = 0;
    mistakes = 0;
    NSError *openFileError = nil;
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Book"
                                                         ofType:@"txt"];
    levelText = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&openFileError];
    if (openFileError){
        DLogError(@"Can't open file. Error: %@",openFileError.description);
    }
}

-(NSString*)levelText{
    return levelText;
}


#pragma mark -
#pragma mark Text field delegate

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString* currentChar = [self.textView currentLetter];
    if ([currentChar rangeOfCharacterFromSet:[NSCharacterSet alphanumericCharacterSet]].location == NSNotFound){
        currentChar = @" ";
    }
    if ([[currentChar lowercaseString] isEqualToString:[string lowercaseString]] || [currentChar isEqualToString:@" "]){
        [self.textView moveLetters];
        lettersTappedRight++;
        if ([self.delegate respondsToSelector:@selector(pointAdded)]){
            [self.delegate pointAdded];
        }
    }
    else {
        mistakes++;
        [self.textView highlightWrongChar];
        if ([self.delegate respondsToSelector:@selector(pointSubstracted)]){
            [self.delegate pointSubstracted];
        }

    }
    return NO;
}


- (void)dealloc
{
    [levelText release];
    self.textView = nil;
    self.delegate = nil;
    [super dealloc];
}



@end
