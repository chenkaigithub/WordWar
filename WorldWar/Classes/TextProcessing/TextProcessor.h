//
//  TextProcessor.h
//  WorldWar
//
//  Created by Dima on 13.04.13.
//
//
#import "TextLineView.h"
#import <Foundation/Foundation.h>

@protocol TextProcessorDelegate <NSObject>

-(void)pointAdded;
-(void)pointSubstracted;

@end

@interface TextProcessor : NSObject <UITextFieldDelegate>{
    NSString *levelText;
    int lettersTappedRight;
    int mistakes;
    
    id <TextProcessorDelegate> delegate;
}

@property (nonatomic,assign) id <TextProcessorDelegate> delegate;
@property (nonatomic,retain) TextLineView* textView;

-(NSString*)levelText;

@end
