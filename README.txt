PORTABLE NEOVIM FOR C# ON WINDOWS
=================================

Neovim 0.12.5 with the config, the plugins, OmniSharp and CSharpier
already installed. Nothing downloads. No install program runs.

The PC needs the .NET SDK. OmniSharp and CSharpier need it.


GET THE FOLDER
--------------

Download the zip file:

   https://github.com/Nomi-y/nvim-win64/archive/refs/tags/v1.0.0.zip

Or clone the repository:

   git clone https://github.com/Nomi-y/nvim-win64.git

The zip file gives the folder nvim-win64-1.0.0. The name does not matter.
This README uses the name nvim-win64.

The folder holds bin, lib, share and tools. Keep the four together.
Neovim reads the config, the plugins and the tools through this structure.


ADD bin TO THE PATH
-------------------

Use one of these three methods. Then open a new terminal window.

A. Double-click add-to-path.bat.
   SmartScreen can block the file. Click "More info", then "Run anyway".

B. Open PowerShell in the nvim-win64 folder. Run this line:

$bin = (Resolve-Path .\bin).Path; $user = [Environment]::GetEnvironmentVariable('Path','User'); if (-not $user) { $user = '' }; if (($user -split ';') -notcontains $bin) { [Environment]::SetEnvironmentVariable('Path', ($user.TrimEnd(';') + ';' + $bin), 'User') }; Write-Host ('PATH now has ' + $bin)

C. Open "Edit environment variables for your account".
   Add the full path of the bin folder to Path, under User variables.

To skip the PATH, copy the nvim-win64 folder into the project folder.
Then run .\nvim-win64\bin\nvim.exe .


CHECK
-----

Run nvim --version. The first line shows NVIM v0.12.5.
Start nvim and run :SetupCheck.
The report lists dotnet, OmniSharp, CSharpier and the plugin count.
A line with NOT FOUND shows a problem.


OPEN A PROJECT
--------------

Run nvim . in the project folder.

OmniSharp starts at the first .cs file.
It needs a .csproj, .sln or .slnx file above that file.
The first start takes 10 to 30 seconds.


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


INSTALLED
---------

   Neovim 0.12.5 for Windows 64-bit
   OmniSharp 1.40.0            tools\omnisharp, tools\omnisharp-framework
   CSharpier 1.2.6             tools\csharpier
   ripgrep 15.2.0, fd 10.5.0   bin
   19 plugins                  lib\nvim\pack\bundle\start
   the config                  lib\nvim\plugin, lib\nvim\lua\win64

This folder holds two OmniSharp builds. The config picks one at start.
It takes tools\omnisharp when the PC has the .NET 10 runtime.
It takes tools\omnisharp-framework in every other case.
That build runs on the .NET Framework of Windows.
:SetupCheck names the build in use.

CSharpier formats every C# file at each write.


TROUBLESHOOTING
---------------

NVIM IS NOT FOUND
The PATH change did not reach the terminal. Open a new terminal window.
If the problem stays, run add-to-path.bat again. Read the message.

:SetupCheck SHOWS "dotnet NOT FOUND"
Install the .NET SDK. OmniSharp and CSharpier need it.

NO DIAGNOSTICS AND NO COMPLETION
OmniSharp needs a project file. Run dotnet new sln.
Then run :checkhealth vim.lsp and read the section "vim.lsp".

THE ICONS SHOW AS BOXES
The terminal font has no icons.
Set the Windows Terminal font to "Cascadia Mono NF".
Then set vim.g.have_nerd_font = true in lib\nvim\lua\win64\options.lua.

NEOVIM SHOWS ERRORS AT START
An older config is at %LOCALAPPDATA%\nvim. Rename that folder.


REMOVE
------

Delete the nvim-win64 folder.
Remove the bin path from the user PATH with method C.
Delete %LOCALAPPDATA%\nvim-data. It holds the undo files.
