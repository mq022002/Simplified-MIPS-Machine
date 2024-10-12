# Progress Report 1

Contributors: Joey Conroy, Abbie Mathew, Matthew Quijano

## Local Instance Instructions

1. The contents of `.zip` should be extracted.

2. Ensure that you have Chocolatey installed on your computer: https://chocolatey.org/install

3. Open a PowerShell terminal as an administrator, and run the following command to install Make:

```ps1
choco install make
```

If you are on MacOS, use the following command to install Make using Homebrew:

```bash
brew install make
```

5. Ensure that Make is installed by running the following command. If it errors out and the installation process succeeded, you will need to restart your computer to ensure that the registry has been updated:

```ps1
make
```

6. A Makefile is already configured for your convenience. Instructions on usage are included there, but just to make sure there is not confusion. Ensure you are in the progress_report_1 directory:

```bash
cd [directory_where_you_have_this_folder_extracted_to]\progress_report_1
make all
```
