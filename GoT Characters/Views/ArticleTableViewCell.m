//
//  ArticleTableViewCell.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "ArticleTableViewCell.h"

NSString * const kArticleTableViewCellReusableIdentifier = @"ArticleTableViewCellReusableIdentifier";

@implementation ArticleTableViewCell

- (IBAction)favouriteStatusButtonTapped:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapFavouriteStatusButton:)]) {
        [self.delegate didTapFavouriteStatusButton:self];
    }
}

@end
