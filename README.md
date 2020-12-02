# cleannames

For Mac OS X, using built in ruby and osascript. 
* Asks for folder
* Walks through the folder's files, and subfolder's files, changing any files names which have these chars in their names
```
~ " # % & * : < > ? / \ { | }.
```
* Bad characters get replaced with X
* multiple '.'s get replaced with __
* Removes leading and trailing spaces
* Name collisions have and index number added to the name.

## Example output
```
​In test
renaming '?.?' to 'X.X'
renaming '#.# ' to 'X_1.X'
renaming '#.?.###' to 'X_X.XXX'
renaming '#.{.###' to 'X_X_1.XXX'
renaming 'test2 ' to 'test2'
In test2
renaming '#.{.###' to 'X_X.XXX'
renaming '#.#.###' to 'X_X_1.XXX'
Back In test
renaming '#.#.###' to 'X_X_2.XXX'
```
