#!/usr/bin/env python3

import os
import re

def replace_colors_in_file(filepath):
    with open(filepath, 'r') as file:
        content = file.read()
    
    # Replace Colors.white with DarkTheme.textPrimary
    updated_content = content.replace('Colors.white', 'DarkTheme.textPrimary')
    
    if content != updated_content:
        with open(filepath, 'w') as file:
            file.write(updated_content)
        print(f"Updated: {filepath}")
    else:
        print(f"No changes needed: {filepath}")

# Find all dart files in questionnaire directory
questionnaire_dir = "lib/view/questionnaire"
for filename in os.listdir(questionnaire_dir):
    if filename.endswith('.dart'):
        filepath = os.path.join(questionnaire_dir, filename)
        replace_colors_in_file(filepath)

print("Color replacement completed!")
