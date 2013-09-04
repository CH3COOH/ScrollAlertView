Copyright (c) 2011 Kenji Wada, http://ch3cooh.jp/

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Welcome

UIAlertViewで長文のテキストを表示することが出来ません。これは、スクロール可能なテキストを表示させるAlertViewを提供するプロジェクトです。ScrollAlertViewの使い方は、UIAlertViewと同じです。

=== Usege ===

あなたのプロジェクトで使用する場合、ScrollAlertView.hとScrollAlertView.mだけをインポートします。ScrollAlertViewSampleプロジェクトを動かしても動作確認が可能です。XCode 3.2.4, iOS SDK 4.2で動作確認を行いました。

===== 普通(キャンセルボタン、ボタンが１つ)にアラートを使用する =====

{{{
#!objc

ScrollAlertView* alert = [[ScrollAlertView alloc] initWithTitle:@"アラートのテスト"  
                                                message:@"こんにちは　ありがとう\nさよなら\nまた会いましょう"
                                               delegate:nil
                                      cancelButtonTitle:@"キャンセル" 
                                      otherButtonTitles:@"ボタンその１",nil];
[alert show];
[alert release];
}}}

{{http://cdn-ak.f.st-hatena.com/images/fotolife/c/ch3cooh393/20110718/20110718223044.png|}}

===== キャンセルボタンとボタンが２つのアラートを使用する =====

{{{
#!objc

ScrollAlertView* alert = [[ScrollAlertView alloc] initWithTitle:@"アラートのテスト"  
                                                message:@"ああああああいいいいいうううううえええええおおおおおおかかかかかきききききくくくくく"
                                               delegate:nil
                                      cancelButtonTitle:@"キャンセル" 
                                      otherButtonTitles:@"ボタン２", @"ボタン１", nil];
[alert show];
[alert release];
}}}

{{http://cdn-ak.f.st-hatena.com/images/fotolife/c/ch3cooh393/20110718/20110718223046.png|}}

===== 表示するテキストの行数を変更する =====

文字数が多くて、表示可能なテキストの行数を超えてしまった場合、スクロールを行います。デフォルト値として表示するテキストの行数は3行としていますが、2行にを変更したい場合、下記のように変更します。

{{{
#!objc

// テキストの行数
//#define TEXT_LINES (3)
#define TEXT_LINES (2)
}}}

{{http://cdn-ak.f.st-hatena.com/images/fotolife/c/ch3cooh393/20110718/20110718223047.png|}}
