//
//  DBNumberPadInputView.h
//  DBNumericInput
//
//  Created by David Barry on 1/31/12.
//  Copyright (c) 2011 David Barry

#import "DBViewWithNibLayout.h"

typedef enum {
    DBNumberPadButton0 = 0,
    DBNumberPadButton1,
    DBNumberPadButton2,
    DBNumberPadButton3,
    DBNumberPadButton4,
    DBNumberPadButton5,
    DBNumberPadButton6,
    DBNumberPadButton7,
    DBNumberPadButton8,
    DBNumberPadButton9,
    DBNumberPadButtonBackspace,
    DBNumberPadButtonDot,
    DBNumberPadButton00,
} DBNumberPadButton;


@protocol DBNumberPadInputDelegate <NSObject, UIInputViewAudioFeedback>
- (void)numberButtonTapped:(DBNumberPadButton)numberPadButton;

@end

@interface DBNumberPadInputView : DBViewWithNibLayout
@property (nonatomic, weak) id <DBNumberPadInputDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *bottomLeftButton;
@property (nonatomic, readonly) BOOL enableInputClicksWhenVisible;

- (IBAction)buttonTapped:(id)sender;
- (IBAction)deleteTapAndHold:(UILongPressGestureRecognizer *)sender;
- (void)setBottomLeftButtonDot;
- (void)setBottomLeftButton00;

+ (id)sharedNumberPadInputView;

@end
