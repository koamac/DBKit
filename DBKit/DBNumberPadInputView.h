//
//  DBNumberPadInputView.h
//  DBKit
//
//  Created by David Barry on 1/31/12.
//  Copyright (c) 2011 David Barry
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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

@interface DBNumberPadInputView : UIView
@property (nonatomic, weak) id <DBNumberPadInputDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *bottomLeftButton;
@property (nonatomic, readonly) BOOL enableInputClicksWhenVisible;

- (IBAction)buttonTapped:(id)sender;
- (IBAction)deleteTapAndHold:(UILongPressGestureRecognizer *)sender;
- (void)setBottomLeftButtonDot;
- (void)setBottomLeftButton00;

+ (DBNumberPadInputView *)numberPadInputView;
+ (DBNumberPadInputView *)sharedNumberPadInputView;

@end
