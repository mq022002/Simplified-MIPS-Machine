# Local Instance Instructions

## Get the repository/code onto your system

1. Open Visual Studio Code. If you do not have it downloaded, go here: https://code.visualstudio.com/
2. Open a new terminal, and clone this GitHub repossitory using the following command. When prompted, open the cloned repository:

```bash
git clone https://github.com/mq022002/Simplified-MIPS-Machine.git
```

3. In your terminal, checkout/go to your specified branch using the following command. Committing to main is not enabled. Code review is necessary before merging changes with everyone else:

```bash
git checkout dev/[your_initials]
```

Example:

```bash
git checkout dev/mq
```

## Set up your environment to run Verilog. Follow this step-by-step, and you should be fine

1. Download the extension. Extensions is the 4 squares, with 1 square being taken off. Just search Verilog, and match the specifications of that extension with the one below:

```
Name: Verilog-HDL/SystemVerilog/Bluespec SystemVerilog
Id: mshr-h.veriloghdl
Description: Verilog-HDL/SystemVerilog/Bluespec SystemVerilog support for VS Code
Version: 1.15.1
Publisher: Masahiro Hiramori
VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=mshr-h.VerilogHDL
```

2. Ensure that you have Icarus Verilog installed on your system. I downloaded the latest version off of the website that our professor provided: https://bleyer.org/icarus/

On Windows, this does NOT go into Program Files. Select all defaults, ensure that it is installed into a folder that contains no space characters. Add to PATH, and restart your system.

On MacOS, you can install Icarus Verilog using Homebrew. If you don't have Homebrew installed, you can install it by running the following command in the terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Makefile

3. Ensure that you have Chocolatey installed on your computer: https://chocolatey.org/install

4. Open a PowerShell terminal as an administrator, and run the following command to install Make:

```ps1
choco install make
```

If you are on MacOS, use the following command to install Make using Homebrew:

```bash
brew install make
```

5. Ensure that make is installed by running the following command. If it it errors out and the installation process succeeded, you will need to restart your computer to ensure that the registry has been updated:

```ps1
make
```

6. A Makefile is already configured for your convenience. Instructions on usage are included there, but just to make sure there is not confusion. Ensure you are in the progress_report_1 directory:

```bash
cd progress_report_1
make compile_and_run_ALU_tb
```

### VS Code Task

3. A tasks.json is already configured for you, and is always in version control should you lose it. Ensure that you always have this file.

4. Open `behavioral_serial_adder.v`. To ensure that everything is working, open the command pallete using the following command:

```
Windows:
CTRL + SHIFT + P

MacOS:
CMD + SHIFT + P
```

Now, type "run task", select it by pressing your 'Enter' key, and select iverliog. This should provide an output file, which is for Verilog, not human-readable. The result that Verilog reads from that output file is then generated into your terminal. You would typically run this on the testbench file, after compiling the file in src. This may be removed in the future though.
