//
//  CHGPlaceholderTextView.h
//  
//
//  Created by chenhongen on 15/9/10.
//
//

#import <UIKit/UIKit.h>

@interface CHGPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
