//
//  ScrollAlertView.m
//  
// Copyright (c) 2011 Kenji Wada, http://ch3cooh.jp/
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files 
// (the "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "ScrollAlertView.h"

@interface ScrollAlertView(Private)
- (CGFloat) getFrameHeight;
- (CGFloat) getScrollViewHeight:(UIFont*)font;
@end


@implementation ScrollAlertView

@synthesize scrollView;

// テキストの行数
#define TEXT_LINES (3)
// TEXT_LINESの行数を下回った状態でもバウンス(跳ね返り)を有効にするか(1:有効 0:無効)
#define SCROLL_BOUNS 0
// フォントのサイズ
#define FONT_SIZE (18.0)

// ボタンの描画を開始する横座標
#define BUTTON_ORIGIN_X (12.0)
// ボタンの描画を開始する縦座標
#define BUTTON_ORIGIN_Y (60.0)
// ボタンの幅
#define BUTTON_WIDTH (260.0)
// ボタンの高さ
#define BUTTON_HEIGHT (50.0)
// スクロールビューの幅
#define SCROLLVIEW_WIDTH (250.0)
// テキストの幅
#define LABEL_WIDTH (235.0)

- (CGFloat) getFrameHeight {
	const int frameBaseHeight = 75; // フレームの大きさ
	
	// ボタンの数からViewの大きさを決める
	int cnt = [[self valueForKey:@"_buttons"] count];
	CGFloat frameHeight = frameBaseHeight + BUTTON_HEIGHT * cnt;
	
	UIFont* systemFont = [UIFont systemFontOfSize:FONT_SIZE];
	frameHeight += [self getScrollViewHeight:systemFont];
	
	return frameHeight;
}

- (CGFloat) getScrollViewHeight:(UIFont*)font {
	// 適当な文字からScrollViewの高さを決める
	NSString* temp = @"あ";
	CGFloat scrollViewHeight = [temp sizeWithFont:font].height * TEXT_LINES;
	
	return scrollViewHeight;
}

#pragma mark -

- (id)initWithTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
	
	// 可変長引数をスーパークラスに渡せないので、nilしか渡さない
	id obj = [super initWithTitle:title message:nil delegate:delegate 
				cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
	if (obj != nil) {
		
		// 内部的にbuttonを追加する
		va_list argumentList;
		if (otherButtonTitles) {
			[obj addButtonWithTitle:otherButtonTitles];
			va_start(argumentList, otherButtonTitles);
			id eachObject = nil; 
			while (eachObject = va_arg(argumentList, id)) {
				[obj addButtonWithTitle:eachObject];
			}
			va_end(argumentList);
		}
		
		// アラート標準のテキストを非表示にする
		UIView* bodyLabel = [self valueForKey:@"_bodyTextLabel"];
		bodyLabel.hidden = YES;
		
		// メッセージの長さからScrollViewのコンテンツの高さを決める
		UIFont* systemFont = [UIFont systemFontOfSize:FONT_SIZE];
		CGSize size = [msg sizeWithFont:systemFont 
					  constrainedToSize:CGSizeMake(LABEL_WIDTH, 500)
						  lineBreakMode:UILineBreakModeCharacterWrap];
		
		// スクロールビューの内部にaddSubviewするUILabelを生成する
		UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LABEL_WIDTH, size.height)];
		[label setLineBreakMode:UILineBreakModeCharacterWrap];
		[label setNumberOfLines:100]; // NOTO: 行の制限を無くす方法はないか？
		[label setFont:systemFont];
		[label setMinimumFontSize:12];
		[label setTextAlignment:UITextAlignmentCenter];
		[label setTextColor:[UIColor whiteColor]];
		[label setBackgroundColor:[UIColor clearColor]];
		[label setShadowColor:[UIColor blackColor]];
		[label setShadowOffset:CGSizeMake(1, 0)];
		[label setText:msg];
		
		// スクロールビューの初期化
		[self.scrollView removeFromSuperview];
		self.scrollView = nil;
		CGRect rect = CGRectMake(25, 50, SCROLLVIEW_WIDTH, [self getScrollViewHeight:systemFont]);
		self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
		[self.scrollView setContentSize:CGSizeMake(size.width, size.height)];
		[self.scrollView setScrollEnabled:YES];
#if SCROLL_BOUNS
		[self.scrollView setAlwaysBounceVertical:YES];
#endif //SCROLL_BOUNS
		[self.scrollView scrollsToTop];
		[self.scrollView addSubview:label];
		[label release];
		[self addSubview:self.scrollView];
	}
	return obj;
}

- (void) setFrame:(CGRect)rect {
	[super setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, [self getFrameHeight])];
}


- (void) layoutSubviews {	
	CGFloat frameHeight = [self getFrameHeight];
	
    // 参照するコントロールがシステムバージョンを取得する
    NSString* className = @"UIThreePartButton";
    NSString* version = [[UIDevice currentDevice] systemVersion];
    double ver = [version doubleValue];
    if (ver >= 5.0) {
        className = @"UIAlertButton";
    }
    
	// UIAlertViewのボタンの位置をここで設定しなおす
	// 非公式APIを使用すれば使えば一発だがボタンを一つずつ配置しなおしていく
	int row = 0;
	for (UIView* view in self.subviews) {

		// UIAlertView上で使用されるボタンはUIButtonではなく
		// UIThreePartButtonという専用なのでクラス名をチェックしていく
		if ([view isKindOfClass:NSClassFromString(className)]) {
			CGRect r = view.frame;
			CGFloat originY = frameHeight - (BUTTON_HEIGHT * row) - BUTTON_ORIGIN_Y;
			view.frame = CGRectMake(BUTTON_ORIGIN_X, originY,
									BUTTON_WIDTH, r.size.height);
			row++;
		}
	}
}

- (void)dealloc {
	self.scrollView = nil;
    [super dealloc];
}


@end
