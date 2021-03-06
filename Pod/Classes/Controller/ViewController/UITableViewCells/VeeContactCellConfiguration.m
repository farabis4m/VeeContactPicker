//
//  Created by Andrea Cipriani on 28/03/16.
//  Copyright © 2016 Code Atlas SRL. All rights reserved.
//

#import "VeeContactCellConfiguration.h"
#import "VeeContactUITableViewCell.h"
#import "UILabel+VeeBoldify.h"
#import "VeeContactPickerOptions.h"
#import "UIImageView+AGCInitials.h"
#import "UIImageView+Letters.h"
#import "VeeCommons.h"
#import "VeeContact.h"

@interface VeeContactCellConfiguration ()

@property (nonatomic,strong) VeeContactPickerOptions* veeContactPickerOptions;

@end

@implementation VeeContactCellConfiguration

#pragma mark - Initializers

- (instancetype)initWithVeePickerOptions:(VeeContactPickerOptions*)veeContactPickerOptions
{
    self = [super init];
    if (self) {
        _veeContactPickerOptions = veeContactPickerOptions;
    }
    return self;
}

#pragma mark - Public Methods

- (void)configureCell:(VeeContactUITableViewCell*)veeContactUITableViewCell forVeeContact:(id<VeeContactProt>)veeContact
{
    [self configureCellLabels:veeContactUITableViewCell forVeeContact:veeContact];
    [self configureCellImage:veeContactUITableViewCell forVeeContact:veeContact];
    [veeContactUITableViewCell.checkmarkImageView setHidden:!_showRadioImage];
}

#pragma mark - Private utils

- (void)configureCellLabels:(VeeContactUITableViewCell*)veeContactUITableViewCell forVeeContact:(id<VeeContactProt>)veeContact
{
    veeContactUITableViewCell.primaryLabel.text = [veeContact displayName];
    NSArray* nameComponents = [[veeContact displayNameSortedForABOptions] componentsSeparatedByString:@" "];
    BOOL isMissingANameComponent = [VeeCommons vee_isEmpty:[veeContact firstName]] || [VeeCommons vee_isEmpty:[veeContact lastName]];
    BOOL nameComponentsAreLessThanOne = [nameComponents count] < 1;
    NSString* toBoldify;
    if (isMissingANameComponent || nameComponentsAreLessThanOne){
        toBoldify = [veeContact displayName];
    }
    else {
        toBoldify = [nameComponents firstObject];
    }
    [veeContactUITableViewCell.primaryLabel vee_boldSubstring:toBoldify];
    
    VeeContact * contact = (VeeContact *)veeContact;
    veeContactUITableViewCell.mobileNumberLabel.text = contact.phoneNumber;
}

- (void)configureCellImage:(VeeContactUITableViewCell*)veeContactUITableViewCell forVeeContact:(id<VeeContactProt>)veeContact
{
    if ([veeContact thumbnailImage]) {
        veeContactUITableViewCell.contactImageView.image = [veeContact thumbnailImage];
    }
    else {
//        if (_veeContactPickerOptions.showInitialsPlaceholder) {
//            [veeContactUITableViewCell.contactImageView agc_setImageWithInitialsFromName:[veeContact displayName] separatedByString:@" "];
//        }
//        else {
//            [veeContactUITableViewCell.contactImageView setImage:_veeContactPickerOptions.contactThumbnailImagePlaceholder];
//        }
        NSString * contactName = @"";
        //--Set beneficiary image with initials  (if image not available)
        if ([veeContact displayName].length > 0) {
            contactName = [NSString stringWithFormat:@"%@",[veeContact displayName]];
            [veeContactUITableViewCell.contactImageView setImageWithString:contactName color:[UIColor colorWithRed:102/255.0 green:122/255.0 blue:148/255.0 alpha:1] circular:YES];
        }
        else {
           [veeContactUITableViewCell.contactImageView setImage:[UIImage imageNamed:@"userMepay"]];
        }
        
        
        
    }
}

@end
