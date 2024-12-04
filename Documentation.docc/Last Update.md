# Last Update

What I worked on last so I don't have to remember by looking through the code.

## Ideas

- When adding transactions, keep the account selected between. I will be adding 15 Apple Card payments, I don't want to have to tap "Apple Card" each time.

### November 1, 2024
- Need to figure out how to use Layout
- Separated the Chip layout thing into separate views
- Started creating the search functionality in addTransactionTEST
- Created DynamicQuery for updating the Predicate filter
- Changed Payment to PaymentMethod and took away the word in the initializer
- 

### October 21, 2024
- Created ChipView for accounts / buckets / etc.
- Currently all inside of "extensions" but its working and its bedtime so I gotta go do that now.
- Will clean up the rest of the code next time!

### October 12, 2024
- Removed Year:Month Picker view
- Changed main app view to be addTransactionView() as that is what was being worked on mainly
- Changed CustomNumberKeyboard to have "." and "Backspace" instead of an enter button. Enter will be taken care of elsewhere
- Added an entirely new way of filling out the form. Now items slide across from right to left one at a time as the form is being filled out.
- Need to figure out how to make selections (Date, Bucket, Account, etc.) the exact same height as the keyboard so everything stays in place.
- Keeps the focus on the currently visible field.
- Need to break up the code to make it more reusable and clean.
- ProgressView was created and used to brainstorm a lot of what addTransactionView currently is.
- 

- Idea: Use the Chip View video to select the accounts/buckets/etc.?
- Idea: Use a search functionality to quickly find buckets/categories/etc. like in Maps and or ConnectWise
- Idea: Have the bar at the bottom show progress instead of being dots. When all the progress is made, it turns into a submit button.

### September 30, 2024

- Changed the homescreen to now be the bucket list view
- Now has a plus button on home screen to add a bucket
- Put in a custom Year/month picker which I'll probably change at some point but it works for now
- Added an info screen to test the custom number typer and find the database files

### September 28, 2024

- Updated the folder structure to organize the project a little more
- PaymentModel is no longer being used, just to simplify the first version. At some point I will need to add it in again.
- Working on using built-in dates instead of the custom built month enum I originally setup. Need to figure out how to use the month as an Int but still display all the months as strings.
- Implemented the custom keyboard
- Starting git repo to keep a better history.
