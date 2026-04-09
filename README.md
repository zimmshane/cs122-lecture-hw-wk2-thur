# Lecture Homework Week 02 - Thursday

For this lecture homework, you will create an **Endianness Converter**. This module will take in four inputs: a clock, a 32-bit integer, the endianness of the input, and the endianness of the output. It has one output: a 32-bit integer representing the converted value.

If you don't remember what endianness is, refer to [this article on Geeks for Geeks](https://www.geeksforgeeks.org/dsa/little-and-big-endian-mystery/). 

Basically, this concept deals with the byte order of multi-byte values. In **little-endian** format, the least significant byte (LSB) is stored at the lowest address. In **big-endian** format, the most significant byte (MSB) is stored at the lowest address. 

For example, the following is the little-endian format of `16'hABCD`:

| Address | Byte Value |
|---------|------------|
| 0x00    | 0xCD       |
| 0x01    | 0xAB       | 

In big-endian format, it is:

| Address | Byte Value |
|---------|------------|
| 0x00    | 0xAB       |
| 0x01    | 0xCD       | 

## Getting the Code

You are not required to write all the code from scratch. Instead, we have provided a scaffolded outline for you to complete.

As with the previous lecture homework, this assignment is hosted on GitHub. You will create your own repository using the assignment repository as a template. To do this:

1. Click on **"Use this template."**
2. Select **"Create a new repository."**
3. Give your repository a descriptive name.
4. Click **"Create repository."**

Once created, clone the repository to your local machine or open it in a GitHub Codespace to begin working.

## Writing the Endianness Converter

You will write a module with four inputs: `clk`, `word`, `endianness_in`, and `endianness_out`. The `word` input is a 32-bit integer, and both `endianness_in` and `endianness_out` are single bits. 

* A bit value of **1** means big-endian.
* A bit value of **0** means little-endian. 

If `endianness_in` and `endianness_out` are the same, the output should match the input since no conversion is needed. If they are different, the byte order of the output should be reversed. For example, if the input is `32'hABCDEF12`, the output would be `32'h12EFCDAB` when the endianness values are not equal.

The following constraints must be followed for your code in the file `endianness_converter.sv`:

1. The conversion output must be **synchronous** (i.e., triggered on the positive edge of the clock).
2. The integer input for the module must be named `word`.
3. The endianness inputs must be 1-bit and named `endianness_in` and `endianness_out`.
4. The clock input must be named `clk`.
5. The module port list must be in the following order:

```verilog
module endianness_converter(
    input clk,
    input word,
    input endianness_in,
    input endianness_out,
    output converted_word
);
```

**Note:** You will need to specify the size of both `word` and `converted_word`. Additionally, you must specify the types for all ports. You can achieve this by either modifying the Verilog code above or declaring their sizes and types at the beginning of the module. This latter style is called an **incomplete declaration**. You can read [this article from ChipVerify](https://www.chipverify.com/verilog/verilog-ports) for more details; see the section titled "Complete vs. Incomplete Declarations."

## Synthesizing

Before running the simulation, you must compile (synthesize) the code using `iverilog`. Run the following command in your terminal:

```sh
iverilog -o testbench -g2009 testbench.sv
```

This command generates a simulation executable named `testbench`.

## Running the Testbench

Run the simulation and observe the results. If your design is correct, you should see:

```sh
VCD info: dumpfile tb.vcd opened for output.
Tests Passed!
```

If the design is incorrect, the output will show:

```sh
VCD info: dumpfile tb.vcd opened for output.
Failed tests
```

If your tests are failing and you cannot identify the error, use **GTKWave** to inspect the waveforms stored in `tb.vcd`.

## What to Turn In

Submit your work by committing and pushing your changes to your GitHub repository.

Finally, upload the assignment via **Gradescope**. When prompted, log in to GitHub, select your homework repository, and submit.