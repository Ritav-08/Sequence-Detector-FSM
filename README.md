# Sequence Detector for Pattern "1011" (Moore FSM) - Verilog

## Overview

This project implements a Moore Finite State Machine (FSM) in Verilog HDL to detect the binary sequence `1011` from a serial input stream. The detector generates an output pulse whenever the target sequence is recognized.

Unlike a Mealy FSM, the output depends only on the current state. Therefore, sequence detection occurs after entering a dedicated detection state.

---

## Design Description

### Moore Sequence Detector

- Detects the binary sequence `1011`
- Accepts serial input (`data_i`)
- Generates output (`dout_o`) upon successful detection
- Supports overlapping sequence detection
- Uses asynchronous active-HIGH reset
- Implemented using Moore FSM architecture

---

## Module Details

### FSM Module

```verilog
module sdFSM1011(
   input  wire clk_i,
   input  wire rst_i,
   input  wire data_i,
   output reg  dout_o
);
```

### Inputs

- `clk_i`  → Clock signal
- `rst_i`  → Active HIGH asynchronous reset
- `data_i` → Serial input stream

### Output

- `dout_o` → Sequence detection output

---

## State Definitions

| State | Binary | Description |
|---------|---------|-------------|
| S0 | 000 | Initial state |
| S1 | 001 | Detected `1` |
| S2 | 010 | Detected `10` |
| S3 | 011 | Detected `101` |
| S4 | 100 | Detected `1011` |

---

## State Diagram

```text
             1
        +--------+
        |        v
   +----+-----> S1 <----+
   |         1 ^        |
   |           |        |
   |0          |1       |
   v           |        |
   S0 --1--> S1        S4
   ^          |         |
   |          0         |
   |          v         |
   +----0---- S2 <---0--+
             |
             |1
             v
             S3
           0 | 1
             v
             S4
```

---

## State Transitions

### S0 (Initial State)

| Input | Next State |
|---------|------------|
| 0 | S0 |
| 1 | S1 |

---

### S1 (Detected "1")

| Input | Next State |
|---------|------------|
| 0 | S2 |
| 1 | S1 |

---

### S2 (Detected "10")

| Input | Next State |
|---------|------------|
| 0 | S0 |
| 1 | S3 |

---

### S3 (Detected "101")

| Input | Next State |
|---------|------------|
| 0 | S2 |
| 1 | S4 |

---

### S4 (Detected "1011")

| Input | Next State |
|---------|------------|
| 0 | S2 |
| 1 | S1 |

Output remains HIGH while the FSM is in state S4.

---

## Output Logic

```verilog
always @(*) begin
   case(state)
      S4:      dout_o = 1'b1;
      default: dout_o = 1'b0;
   endcase
end
```

Equivalent form:

```verilog
assign dout_o = (state == S4);
```

---

## Detection Example

Input Sequence:

```text
1 0 1 1
```

State Transitions:

```text
S0 → S1 → S2 → S3 → S4
```

Output:

```text
0 0 0 0 1
```

Because this is a Moore FSM, the output becomes HIGH only after entering the detection state S4.

---

## Overlapping Sequence Detection

The design supports overlapping pattern detection.

Example:

```text
Input Stream:
1011011
```

Detected Patterns:

```text
1011
   1011
```

Output:

```text
0001001
```

---

## Testbench Description

The testbench performs the following:

- Generates clock signal
- Applies asynchronous reset
- Feeds predefined sequence data
- Tests overlapping detections
- Generates random input stream
- Maintains a 4-bit shift register for observation
- Displays current state, sequence, and detection status
- Dumps simulation waveform

---

## Testbench Sequence

### Reset

```verilog
rst_ti = 1'b1;
#10 rst_ti = 1'b0;
```

---

### Applied Input Pattern

```text
1 → 0 → 1 → 1 → 0 → 1 → 1 → 1 → 0 → 1 → 0
```

This sequence intentionally contains multiple occurrences of the target pattern.

---

## Sample Simulation Output

```text
Time: 55 | Clk: 1, Rst: 0 | State: 4 | Sequence: 1011 | Detection: 1
Time: 65 | Clk: 1, Rst: 0 | State: 2 | Sequence: 0110 | Detection: 0
Time: 75 | Clk: 1, Rst: 0 | State: 3 | Sequence: 1101 | Detection: 0
Time: 85 | Clk: 1, Rst: 0 | State: 4 | Sequence: 1011 | Detection: 1
```

---

## Waveform

Generated waveform file:

```text
MooreFSM.vcd
```

View waveform using GTKWave:

```bash
gtkwave MooreFSM.vcd
```

---

## How to Run (Icarus Verilog)

### Compile

```bash
iverilog -o mooreFSM sdFSM1011.v
```

### Run Simulation

```bash
vvp mooreFSM
```

### Open Waveform

```bash
gtkwave MooreFSM.vcd
```

---

## Features

- Moore FSM implementation
- Detects sequence `1011`
- Supports overlapping detection
- Asynchronous reset
- Synthesizable RTL design
- Five-state architecture
- Clean separation of state and output logic

---

## Applications

- Digital pattern recognition
- Communication receivers
- Protocol monitoring
- Serial data processing
- Embedded control systems
- FPGA and ASIC designs

---

## Moore FSM vs Mealy FSM

| Feature | Moore FSM | Mealy FSM |
|----------|------------|------------|
| Output depends on | Current state only | State and input |
| States required | More | Fewer |
| Output response | One clock later | Immediate |
| Glitch susceptibility | Lower | Higher |
| Hardware complexity | Slightly higher | Slightly lower |

---

## Notes

- Detection occurs after entering state S4.
- The FSM supports overlapping pattern recognition.
- Output remains HIGH only while in the detection state.
- The design is fully synthesizable and FPGA-friendly.
- A 4-bit shift register in the testbench helps visualize the received sequence.

---
