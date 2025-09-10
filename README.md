
### 2. `Gray_To_Binary`
Converts Gray code back to binary by XOR-ing prefix bits.

### 3. `Synchronizer`
Two-flop synchronizer for safe signal transfer between clock domains.  
Supports **synchronous** or **asynchronous reset**.

### 4. `Sync_Gray`
- Converts binary pointer to Gray code.
- Synchronizes it bit by bit across the other clock domain.
- Converts it back to binary.

### 5. `Q5` (Main FIFO)
Implements:
- Dual-clock FIFO with `clk_a` (write clock) and `clk_b` (read clock).
- Write and read pointers with wrap detection.
- Full/Empty flag generation using synchronized pointers.

---

## 📝 Signals

- **Inputs**
  - `din_a`: Data input (write side)
  - `wen_a`: Write enable
  - `ren_b`: Read enable
  - `clk_a`: Write clock
  - `clk_b`: Read clock
  - `rst`: Reset (synchronous)

- **Outputs**
  - `dout_b`: Data output (read side)
  - `full`: FIFO full flag
  - `empty`: FIFO empty flag

---

## ⚙️ Parameters
- `FIFO_WIDTH` = 16 (data width per entry)
- `FIFO_DEPTH` = 512 (number of entries)
- Internal pointer width = 9 bits (`log2(512)`)

---

## 🔑 Features
- Safe **clock domain crossing (CDC)** using Gray code.
- Handles **full and empty** conditions reliably.
- Simple and modular design (easy to integrate into larger SoC).

---



// Read at clk_b domain
ren_b = 1;
