//
//  ArticlesTableViewController.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <WebImage/UIImageView+WebCache.h>
#import "ArticlesTableViewController.h"
#import "ArticleTableViewCell.h"
#import "GoTWikiaArticle.h"
#import "GoTWikiaFetcher.h"
#import "FavouriteArticlesManager.h"
#import "ArticleDetailsViewController.h"

NSString * const kMostViewedArticlesDefaultCategory = @"Characters";
NSUInteger const kMostViewedArticlesDefaultLimit    = 75;

NSString * const kShowArticleDetailsSegue = @"ShowArticleDetailsSegue";

@interface ArticlesTableViewController () <ArticleTableViewCellDelegate>
@property NSArray *mostViewedArticles;
@property FavouriteArticlesManager *favouriteArticlesManager;
@end

@implementation ArticlesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refetchMostViewedArticles) forControlEvents:UIControlEventValueChanged];

    self.favouriteArticlesManager = [[FavouriteArticlesManager alloc] init];

    [self refetchMostViewedArticles];
}

- (void)refetchMostViewedArticles
{
    [self.refreshControl beginRefreshing];

    GoTWikiaFetcher *fetcher = [[GoTWikiaFetcher alloc] init];
    [fetcher fetchMostViewedArticlesFromCategory:kMostViewedArticlesDefaultCategory withLimit:kMostViewedArticlesDefaultLimit completionHandler:^(NSArray *fetchedArticles) {
        if (fetchedArticles != nil) {
            self.mostViewedArticles = fetchedArticles;

            for (GoTWikiaArticle *article in fetchedArticles) {
                article.favourite = [self.favouriteArticlesManager isArticleAddedToFavourites:article];
            }

            [self.tableView reloadData];
        }

        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - ArticleTableViewCell Delegate

- (void)didTapFavouriteStatusButton:(id)sender
{
    if ([sender isKindOfClass:[ArticleTableViewCell class]]) {
        ArticleTableViewCell *cell = (ArticleTableViewCell *)sender;
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        GoTWikiaArticle *article = self.mostViewedArticles[path.row];

        UIImage *newStatusImage = nil;

        article.favourite = !article.favourite;

        if (article.isFavourite) {
            [self.favouriteArticlesManager addArticleToFavourites:article];
            newStatusImage = [UIImage imageNamed:@"FavouriteButtonSelected"];
        } else {
            [self.favouriteArticlesManager removeArticleFromFavourites:article];
            newStatusImage = [UIImage imageNamed:@"FavouriteButtonNotSelected"];
        }

        [cell.favouriteStatusButton setImage:newStatusImage forState:UIControlStateNormal];
    }
}

- (void)didLongPressOnAbstractLabel:(id)sender
{
    if ([sender isKindOfClass:[ArticleTableViewCell class]]) {
        ArticleTableViewCell *cell = (ArticleTableViewCell *)sender;
        cell.abstractLabel.numberOfLines = cell.abstractLabel.numberOfLines ? 0 : 2;

        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mostViewedArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleTableViewCellReusableIdentifier forIndexPath:indexPath];
    
    GoTWikiaArticle *article = self.mostViewedArticles[indexPath.row];

    cell.titleLabel.text = article.title;
    cell.abstractLabel.text = article.abstract;
    [cell.favouriteStatusButton setImage:[UIImage imageNamed:article.isFavourite ? @"FavouriteButtonSelected" : @"FavouriteButtonNotSelected"]
                                forState:UIControlStateNormal];
    [cell.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:article.thumbnailURL]
                           placeholderImage:[UIImage imageNamed:@"CharacterImagePlaceholder"]];

    cell.delegate = self;

    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[ArticleTableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:kShowArticleDetailsSegue] &&
                [segue.destinationViewController isKindOfClass:[ArticleDetailsViewController class]]) {
                    ArticleDetailsViewController *advc = segue.destinationViewController;
                    advc.article = self.mostViewedArticles[indexPath.row];
            }
        }
    }
}

@end
