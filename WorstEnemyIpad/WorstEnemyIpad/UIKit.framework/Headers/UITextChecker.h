//
//  UITextChecker.h
//  UIKit
//
//  Copyright 2009-2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKitDefines.h>
#import <Foundation/Foundation.h>

/* A UITextChecker object is used by a client (e.g. a document in an application) to check a given NSString. Generally one UITextChecker instance should be created per document.  Multiple related pieces of text may share a single UITextChecker instance, if they are intended to share ignored words and other similar state.
*/

UIKIT_CLASS_AVAILABLE(3_2) @interface UITextChecker : NSObject {
@private
    id _checker;
    id _reserved;
    NSInteger _usdt;
}

/* Initiates a spell-check of a string.  Returns the range of the first misspelled word, or {NSNotFound, 0} if none is found.  Checking is limited to the range specified, and starts at the specified offset (which should lie within the range), but if wrapFlag is YES then it will check from the beginning of the range if no misspelling is found between startingOffset and the end of the range. */
- (NSRange)rangeOfMisspelledWordInString:(NSString *)stringToCheck range:(NSRange)range startingAt:(NSInteger)startingOffset wrap:(BOOL)wrapFlag language:(NSString *)language;

/* Returns an array of strings, in the order in which they should be presented, representing guesses for words that might have been intended in place of the misspelled word at the given range in the given string. */
- (NSArray *)guessesForWordRange:(NSRange)range inString:(NSString *)string language:(NSString *)language;

/* Returns an array of strings, in the order in which they should be presented, representing complete words that the user might be trying to type when starting by typing the partial word at the given range in the given string. */
- (NSArray *)completionsForPartialWordRange:(NSRange)range inString:(NSString *)string language:(NSString *)language;

/* Methods for dealing with ignored words. */
- (void)ignoreWord:(NSString *)wordToIgnore;
- (NSArray *)ignoredWords;
- (void)setIgnoredWords:(NSArray *)words;

/* These allow clients to programmatically instruct the checker to learn and unlearn words, and to determine whether a word has been learned (and hence can potentially be unlearned). */
+ (void)learnWord:(NSString *)word;
+ (BOOL)hasLearnedWord:(NSString *)word;
+ (void)unlearnWord:(NSString *)word;

/* Entries in the availableLanguages list are all available spellchecking languages in user preference order, usually language abbreviations such as en_US. */
+ (NSArray *)availableLanguages;

@end
