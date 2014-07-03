//
//  FeCell.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 7/3/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeCell.h"

@implementation FeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
