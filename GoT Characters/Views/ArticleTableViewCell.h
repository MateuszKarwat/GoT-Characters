//
//  ArticleTableViewCell.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kArticleTableViewCellReusableIdentifier;

@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UIButton *favouriteStatusButton;

@end
