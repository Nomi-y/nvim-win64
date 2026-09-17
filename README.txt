PORTABLE NEOVIM FOR C# ON WINDOWS
=================================

Neovim 0.12.5 with the config, the plugins, OmniSharp and CSharpier
already installed. Nothing downloads. No install program runs.

The PC needs the .NET SDK. OmniSharp and CSharpier need it.


1. GET THE FOLDER
-----------------

From the zip file:
   Right-click the zip file. Select "Extract All".

From git:
   git clone https://github.com/Nomi-y/nvim-win64.git

Both give one folder:

   nvim-win64\bin\nvim.exe
   nvim-win64\lib\
   nvim-win64\share\
   nvim-win64\tools\

Keep the four folders together. Neovim reads the config, the plugins and
the tools through this structure.


2. ADD bin TO THE PATH
----------------------

METHOD A - THE SUPPLIED FILE

1. Double-click add-to-path.bat in the nvim-win64 folder.
2. Close every terminal window. Open a new one.

SmartScreen can show "Windows protected your PC".
Click "More info". Then click "Run anyway".

METHOD B - ONE LINE IN POWERSHELL

1. Hold Shift. Right-click on free space in the nvim-win64 folder.
2. Select "Open PowerShell window here".
3. Paste this line. Press Enter.

$bin = (Resolve-Path .\bin).Path; $user = [Environment]::GetEnvironmentVariable('Path','User'); if (-not $user) { $user = '' }; if (($user -split ';') -notcontains $bin) { [Environment]::SetEnvironmentVariable('Path', ($user.TrimEnd(';') + ';' + $bin), 'User') }; Write-Host ('PATH now has ' + $bin)

4. Close the window. Open a new terminal window.

METHOD C - THE WINDOWS DIALOG

1. Press the Windows key. Type: environment
2. Open "Edit environment variables for your account".
3. Select the row "Path" under "User variables". Click "Edit".
4. Click "New". Type the full path of the bin folder.
5. Click "OK" in every open window.
6. Close every terminal window. Open a new one.

WITHOUT A PATH CHANGE

Copy the nvim-win64 folder into the project folder. Then run:

   .\nvim-win64\bin\nvim.exe .


3. CHECK
--------

   nvim --version       shows NVIM v0.12.5
   nvim                 then type :SetupCheck and press Enter

:SetupCheck lists dotnet, OmniSharp, CSharpier and the plugin count.
A line with NOT FOUND shows a problem.


OPEN A PROJECT
--------------

1. Hold Shift. Right-click on free space in the project folder.
2. Select "Open PowerShell window here".
3. Type: nvim .

OmniSharp starts at the first .cs file. It needs a .csproj, .sln or
.slnx file above that file. The first start takes 10 to 30 seconds.


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

CSharpier formats every C# file at each write.


INSTALLED
---------

   Neovim 0.12.5 for Windows 64-bit
   OmniSharp 1.40.0          tools\omnisharp, tools\omnisharp-framework
   CSharpier 1.2.6           tools\csharpier
   ripgrep 15.2.0, fd 10.5.0 bin
   19 plugins                lib\nvim\pack\bundle\start
   the config                lib\nvim\plugin, lib\nvim\lua\win64

Two OmniSharp builds ship here. The config picks one at start.
It takes tools\omnisharp when the PC has the .NET 10 runtime.
It takes tools\omnisharp-framework in every other case, because that
build runs on the .NET Framework of Windows itself.
:SetupCheck names the build in use.


TROUBLESHOOTING
---------------

NVIM IS NOT FOUND
The PATH change did not reach the terminal. Open a new terminal window.
If the problem stays, run add-to-path.bat again. Read the message.

:SetupCheck SHOWS "dotnet NOT FOUND"
Install the .NET SDK. OmniSharp and CSharpier need it.

NO DIAGNOSTICS AND NO COMPLETION
OmniSharp needs a project file. Run: dotnet new sln
Then type :checkhealth vim.lsp and read the section "vim.lsp".

THE ICONS SHOW AS BOXES
The terminal font has no icons.
Set the Windows Terminal font to "Cascadia Mono NF".
Then set vim.g.have_nerd_font = true in lib\nvim\lua\win64\options.lua.

NEOVIM SHOWS ERRORS AT START
An older config is at %LOCALAPPDATA%\nvim. Rename that folder.


REMOVE
------

1. Delete the nvim-win64 folder.
2. Remove the bin path from the user PATH with method C.
3. Delete %LOCALAPPDATA%\nvim-data. It holds the undo files.
