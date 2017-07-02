//
//  Created by Andrea Cipriani on 14/12/15.
//  Copyright © 2015 Code Atlas SRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VeeContactUITableViewCell : UITableViewCell

@property (strong, nonatomic)IBOutlet UIImageView *contactImageView;
@property (strong, nonatomic)IBOutlet UILabel	  *primaryLabel;
@property (strong, nonatomic)IBOutlet UILabel	  *mobileNumberLabel;
@property (strong, nonatomic)IBOutlet UIImageView *checkmarkImageView;

@end
