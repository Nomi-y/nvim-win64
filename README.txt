PORTABLE NEOVIM FOR C# ON WINDOWS
=================================

This folder holds a portable Neovim 0.12.5 for Windows 64-bit.
This folder also holds the editor config, the plugins, the OmniSharp
language server and the CSharpier formatter.
Nothing downloads at first start. No install program runs.

Neovim reads the config and the plugins from this folder structure.
It does not read %LOCALAPPDATA%\nvim. It needs no environment variable.
The folder works for any Windows user, and from a USB drive.


WHAT THE PC MUST HAVE
---------------------

- Windows 10 or Windows 11, 64-bit.
- The .NET 10 SDK. OmniSharp and CSharpier need it.

The PC does not need internet access.
The PC does not need git.
The PC does not need a script to run.
The PC does not need admin rights.


STEP 1 - GET THE FOLDER ONTO THE PC
-----------------------------------

METHOD A - FROM THE ZIP FILE

1. Copy the zip file to the PC.
2. Right-click the zip file.
3. Select "Extract All".
4. Select a folder that the local user can write to.
   Example: C:\Users\<user>\Tools
5. Click "Extract".

METHOD B - FROM GIT

Use this method on a test machine with git and internet access.

1. Open PowerShell.
2. Type: git clone https://github.com/Nomi-y/nvim-win64.git
3. Press Enter.

Both methods give one folder with this structure:

   ...\nvim-win64\bin\nvim.exe
   ...\nvim-win64\lib\
   ...\nvim-win64\share\
   ...\nvim-win64\tools\

Write down the full path of the bin folder. Step 2 needs this path.
Example: C:\Users\<user>\Tools\nvim-win64\bin

Do not move the bin folder out of the nvim-win64 folder.
Neovim finds the config, the plugins and the tools through this structure.


STEP 2 - ADD THE BIN FOLDER TO THE PATH
---------------------------------------

Use method A. Method A needs no typing.

METHOD A - RUN THE SUPPLIED FILE

1. Open the nvim-win64 folder in Explorer.
2. Double-click the file add-to-path.bat.
3. Read the message. The message shows the folder that it added.
4. Press a key to close the window.
5. Close every terminal window.
6. Open a new terminal window.

The file adds its own bin folder to the user PATH.
The file changes the user PATH only. The file leaves the system PATH alone.
The file does not need admin rights.

Windows can show a blue box with the text "Windows protected your PC".
Click "More info". Then click "Run anyway".

METHOD B - PASTE ONE LINE INTO POWERSHELL

1. Open the nvim-win64 folder in Explorer.
2. Hold Shift. Right-click on free space in the window.
3. Select "Open PowerShell window here".
4. Copy the line below. Right-click in the window to paste it.

$bin = (Resolve-Path .\bin).Path; $user = [Environment]::GetEnvironmentVariable('Path','User'); if (-not $user) { $user = '' }; if (($user -split ';') -notcontains $bin) { [Environment]::SetEnvironmentVariable('Path', ($user.TrimEnd(';') + ';' + $bin), 'User') }; Write-Host ('PATH now has ' + $bin)

5. Press Enter.
6. Close the window.
7. Open a new terminal window.

The line reads the folder from the current directory. You type no path.
The line is a command. The line is not a script file.
An execution policy does not block a pasted command.

METHOD C - THE WINDOWS DIALOG

Use this method if PowerShell is blocked.

1. Press the Windows key.
2. Type: environment
3. Open "Edit environment variables for your account".
4. Select the row "Path" in the upper list, "User variables".
5. Click "Edit".
6. Click "New".
7. Type the full path of the bin folder from step 1.
8. Click "OK" in every open window.
9. Close every terminal window.
10. Open a new terminal window.


IF YOU CANNOT CHANGE THE PATH
-----------------------------

Neovim also runs from the project folder. The PATH stays untouched.

1. Copy the whole nvim-win64 folder into the project folder.
2. Open the project folder in Explorer.
3. Hold Shift. Right-click on free space in the window.
4. Select "Open PowerShell window here".
5. Type: .\nvim-win64\bin\nvim.exe .
6. Press Enter.

Neovim finds its runtime from the path of nvim.exe.
It finds the config, the plugins and the tools next to that path.
Keep the folders bin, lib, share and tools together.


STEP 3 - TEST THE INSTALL
-------------------------

1. Open a new PowerShell window.
2. Type: nvim --version
3. Press Enter. The first line must show NVIM v0.12.5.
4. Type: nvim
5. Press Enter.
6. Type: :SetupCheck
7. Press Enter.

The report opens in a split window. Read every line.
Each line must show a path or a version number.
A line with "NOT FOUND" shows a problem. Read TROUBLESHOOTING below.

8. Type: :qa
9. Press Enter.


HOW TO OPEN A PROJECT
---------------------

METHOD A - FROM EXPLORER

1. Open the project folder in Explorer.
2. Hold Shift. Right-click on free space in the window.
3. Select "Open PowerShell window here".
4. Type: nvim .
5. Press Enter.

METHOD B - FROM THE ADDRESS BAR

1. Open the project folder in Explorer.
2. Click the address bar.
3. Type: powershell
4. Press Enter.
5. Type: nvim .
6. Press Enter.

The command "nvim ." opens the file tree in the project root.
OmniSharp starts when you open the first .cs file.
The first start takes 10 to 30 seconds. OmniSharp reads the project first.


KEYS
----

The leader key is the space bar.

FILES AND SEARCH
   Space e         open or close the file tree
   Space s f       find a file by name
   Space s g       search for text in the project
   Space s d       list all diagnostics
   Space s r       repeat the last search
   Space Space     list the open files
   Space /         search in the open file

CODE
   g d             go to the definition
   g r             list the references
   g I             list the implementations
   g O             list the symbols in the file
   F2              rename the symbol
   Space c a       show the code actions
   Ctrl-k          show the documentation
   Space t h       turn the inlay hints on or off
   Space f         format the file
   Space w d       show the error on this line
   Space q         put all diagnostics in a list
   Space R         restart the language server

EDITOR
   g z             open or close the terminal
   Esc Esc         leave the terminal mode
   Alt-j           move the line down
   Alt-k           move the line up
   g c c           comment the line
   g c             comment the selection
   Ctrl-a          select all
   J               move 10 lines down
   K               move 10 lines up
   Ctrl-h/j/k/l    move to another window

HELP
   Space ?         show the key list
   Space l i       show the language server health report
   :SetupCheck     show the setup report
   :checkhealth    show the Neovim health report

C# SNIPPETS
Type the short word. Press Ctrl-Space. Select the snippet.
   gs    { get; set; }
   gp    { get; private set; }
   prop  a full property
   pk    a primary key with Entity Framework attributes
   fk    a foreign key attribute
   dset  a DbSet property
   tt    an xUnit test method
   try   a try-catch block


WHAT IS INSTALLED
-----------------

Editor
   Neovim 0.12.5 for Windows 64-bit

C# tools, in the folder nvim-win64\tools
   OmniSharp 1.40.0, the language server
   CSharpier 1.2.6, the formatter

Search tools, in the folder nvim-win64\bin
   ripgrep 15.2.0
   fd 10.5.0

Plugins, in the folder nvim-win64\lib\nvim\pack\bundle\start
   blink.cmp                completion
   catppuccin               color theme
   Comment.nvim             comment keys
   conform.nvim             format on save
   friendly-snippets        snippet collection
   indent-blankline.nvim    indent lines
   LuaSnip                  snippet engine
   mini.nvim                status line, text objects, surround
   neo-tree.nvim            file tree
   nui.nvim                 window library
   nvim-autopairs           bracket pairs
   nvim-lspconfig           language server settings
   nvim-web-devicons        icons
   plenary.nvim             helper library
   telescope.nvim           fuzzy finder
   telescope-ui-select.nvim menu style
   toggleterm.nvim          terminal window
   vim-visual-multi         multiple cursors
   which-key.nvim           key list

Helper, in the folder nvim-win64
   add-to-path.bat          adds the bin folder to the user PATH

Config, in the folder nvim-win64\lib\nvim
   plugin\win64.lua         the start file
   lua\win64\options.lua    editor options
   lua\win64\keymaps.lua    keys
   lua\win64\plugins.lua    plugin settings
   lua\win64\lsp.lua        OmniSharp settings
   lua\win64\format.lua     CSharpier settings
   lua\win64\check.lua      the :SetupCheck report
   snippets\cs.lua          the C# snippets

Format on save is on for C# files. CSharpier formats the file at each write.


TROUBLESHOOTING
---------------

"nvim" IS NOT FOUND
The PATH change did not reach the terminal.
Close every terminal window. Open a new one.
If the problem stays, run add-to-path.bat again. Read the message.
If the message shows an error, use method B or method C of step 2.
Read also "IF YOU CANNOT CHANGE THE PATH".

:SetupCheck SHOWS "dotnet NOT FOUND"
The .NET SDK is missing, or the SDK is not on the PATH.
Type "dotnet --version" in PowerShell to confirm this.
Install the .NET 10 SDK. OmniSharp and CSharpier do not work without it.

:SetupCheck SHOWS "omnisharp NOT FOUND"
The tools folder is missing.
Get the folder again. Keep the folder structure.

OMNISHARP DOES NOT START
1. Open a .cs file in a folder with a .csproj file or a .sln file.
2. Wait 30 seconds.
3. Type: :checkhealth vim.lsp
4. Read the section "vim.lsp".
The server needs a project file. OmniSharp does not start for a single file.

THE ICONS SHOW AS BOXES
The terminal font has no icons. Two options exist.
Option 1: keep the boxes away. The config is already in text mode.
Option 2: turn the icons on.
1. Open Windows Terminal. Open the settings.
2. Select the profile. Set the font to "Cascadia Mono NF".
3. Open the file nvim-win64\lib\nvim\lua\win64\options.lua in Neovim.
4. Change "vim.g.have_nerd_font = false" to "vim.g.have_nerd_font = true".
5. Save the file. Restart Neovim.

THE TERMINAL (g z) DOES NOT OPEN
The config uses PowerShell as the shell.
If PowerShell is blocked, open the file lua\win64\options.lua.
Delete the block that starts with "if is_windows then".
Save the file. Restart Neovim. Neovim then uses the default shell.

FORMAT ON SAVE DOES NOTHING
1. Type: :ConformInfo
2. Read the list. The formatter "csharpier" must show as available.
If dotnet is missing, the format step is off. Read the dotnet item above.

NEOVIM SHOWS ERRORS AT START
An older config can be on the PC.
Neovim reads %LOCALAPPDATA%\nvim in addition to this folder.
1. Open Explorer.
2. Type %LOCALAPPDATA% in the address bar. Press Enter.
3. Rename a folder with the name nvim to nvim-old.
4. Start Neovim again.

THE COLORS LOOK WRONG
The theme uses a transparent background.
The terminal color scheme shows through. This is expected.


HOW TO REMOVE
-------------

1. Delete the nvim-win64 folder.
2. Remove the bin path from the user PATH. Use method C of step 2.
3. Delete the folder %LOCALAPPDATA%\nvim-data. It holds the undo files only.
