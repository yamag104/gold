//
//  RecordTableViewCell.h
//  gold
//
//  Created by Brian Wong on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;

@end
