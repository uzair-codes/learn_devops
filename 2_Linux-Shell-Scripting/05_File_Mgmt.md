# Section 5: File Management & vim Editor

## 📁 File Management in Linux

File management means:

* Creating files/directories
* Viewing content
* Copying, moving, deleting files

## 🧰 Important File Management Commands

1. `touch file.txt`         # Creates an empty file
2. `vim file.txt`           # Creates file if not persent and open in vim editor
3. `rm file.txt`            # Remove a file
4. `mkdir mydir`            # Creates a directory
5. `rmdir mydir`            # Remove an empty dir/
6. `rm -rf mydir`           # Remove non-empty dir/ (`-r` = recursively, `-f` = forcefully)
7. `cp src dest`            # Copies file to another location (e.g. cp file.txt /home/uzair/)
8. `cp -r src dest`         # Copy Directory `-r` = recursive (copy directory)
9. `mv src dest`            # Move / Rename File (e.g. mv file.txt newfile.txt, mv file.txt /home/uzair/ )
10. `cat file.txt`          # View file content
11. `less file.txt`         # Pager command, View Large File, forward & backward Scrollable view
12. `more file.txt`         # Pager command, View Large File, only forward Scrollable view
13. `head -n 10 file.txt`   # Display first 10 lines of a file
14. `tail -n 5 file.txt`    # Display last 5 lines of a file
15. `tail -f -n 10 file.txt`# Display last 10 lines of a file and keep monitoring for any new line
16. `grep "error" file.txt` # Search for patterns Inside File
17. `wc file.txt`           # Count Lines, Words, Characters
18. `nl file.txt`           # Number lines of file, Option `-vn` = start numbering from `n` (e.g. `-v0` = start numbering form `0`)
19. `scp -i .pem src dest`  # Copy file to remote server (scp -i <path/to/(.pem)privateKey> <path/to/src/file> <username@ip:path/to/dest/file>)

### rsync

`rsync [options] [SOURCE] [DESTINATION]`

The `rsync` command in Ubuntu Linux is a powerful utility used for efficiently synchronizing files and directories both locally and remotely. It intelligently copies only the changes (new or modified files), making it faster than a full copy.

* `options`: Flags to control the behavior (e.g., recursive, archive mode, compress).
* `SOURCE`: The directory or file path you are copying from.
* `DESTINATION`: The directory or path you are copying to.

```bash
rsync -avz /path/to/source/ user@remote:/path/to/backup/
```

* `-a` means "archive mode"
* `-v` provides "verbose" output
* `-z` option adds compression during the transfer
* `--delete` option ensures the destination is an exact mirror of the source, removing files in the destination that are not present in the source.
* `--progress` option displays a progress bar for ongoing file transfers.
* `--exclude 'dir_name' or 'filename` Exclude specific files or directories.
Example

```bash
rsync -av --exclude '*.log' /path/to/source/ /path/to/destination/
```

## ✍️ vim Editor (Very Important)

vim is a **powerful text editor** used in Linux

```bash
vim file.txt # Open File in vim
```

### ⚙️ vim Modes

vim has 3 main modes:

#### 1. Normal Mode (Default)

* Used for navigation
* Press `Esc` to return here

##### Navigation Options

1. `h`         - move one character left, `nh` - move `n` characters left
2. `l`         - move one character right, `nl` - move `n` characters right
3. `b`         - move one word left, `nb` - move `n` word left
4. `w`         - move one word right, `nw` - move `n` word right
5. `j`         - move one line below, `nj` - move `n` lines below
6. `k`         - move one line above, `nk` - move `n` lines above
7. `0`         - move to the beginning of the line
8. `^`         - move to first non-zero character
9. `$`         - move to the end of line
10. `gg`       - move to the beginning of file
11. `G`        - move to the end of file
12. `:n`       - move to line `n`
13. `u`        - undo last change
14. `crtl+r`   - redo last change
15. `/pattern` - Search for pattern (forword) (n = next, N = pervious)
16. `?pattern` - Search for pattern (backword) (n = next, N = pervious)

##### Delete Lines

1. `dd` or `D` - Delete current line
2. `dnh` - Delete `n` characters left, `dnl` - Delete `n` characters right
3. `dnb` - Delete `n` words Backword,  `dnw` - Delete `n` words forward
4. `dnj` - Delete `n` lines below,     `dnk` - Delete `n` lines above

##### Change Lines

1. `cc` or `C` - Change Current line
2. `cnh` - Change `n` characters left, `cnl` - Change `n` characters right

##### Yank or Copy

1. `yy` or `Y` - Copy Current line
2. `ynh` - Copy `n` characters left, `ynl` - Copy `n` characters right

##### Paste

1. `P` - Paste before cursor
2. `p` - Paste after cursor

#### 2. Insert Mode

* Used for typing text

👉 Press:

```bash
i # for insert at coursor
a # for insert after cousor
I # for insert in the beginning of the line
A # for insert at the end of the line
o # for opening a new line below
O # for opening a new line above
```

#### 3. Command or Ex Mode

* Used for saving, exiting

👉 Press `esc` to return back to Normal Mode then press **`:`** to enter Command or Ex mode

##### Ex Mode Important commands

1. `:w` = Save, `:q` = Quit, `:wq` = Save and Quit, `:q!` = Exit Without Saving, `:wq!` = Save and Quit forcefully
2. `:e filename`    # Open another file
3. `:w filename`    # copy current file's content to another file
4. `:split`         # Split screen horizontaly, **ctrl+w+w**  switch between screens
5. `:vsplilt`       # Split screen vertically, **ctrl+w+w**  switch between screens
6. `:s/old/new`     # Replace first occurance of "old" with "new" in current line
7. `:s/old/new/g`   # Replace all occurance in current line
8. `:%s/old/new`    # Replace first occurance in every line
9. `:%s/old/new/g`  # Replace all occurances of "old" with "new" in whole file

---
