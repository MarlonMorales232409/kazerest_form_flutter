#!/bin/bash

# Replace Colors.white with DarkTheme.textPrimary in all questionnaire dart files
find lib/view/questionnaire -name "*.dart" -type f -exec sed -i 's/Colors\.white/DarkTheme.textPrimary/g' {} +

echo "Replacement completed"
