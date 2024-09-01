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

This does NOT go into Program Files if you're on Windows. Select all defaults, ensure that it is installed into a folder that contains no space characters. Add to PATH, and restart your system.

3. A tasks.json is already configured for you, and is always in version control should you lose it. Ensure that you always have this file.

4. Open `behavioral_serial_adder.v`. To ensure that everything is working, open the command pallete using the following command:

```
Windows:
CTRL + SHIFT + P

MacOS:
CMD + SHIFT + P
```

Now, type "run task", select it by pressing your 'Enter' key, and select iverliog. This should provide an output file, which is for Verilog, not human-readable. The result that Verilog reads from that output file is then generated into your terminal.
