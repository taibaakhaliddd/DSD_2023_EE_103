module projectdsd #(
    parameter SIM = 0
)(
    input  logic        clk, rst,
    input  logic        dir_pin_init,     // Initial direction: 1 = up, 0 = down
    input  logic        enable,           // Enable movement
    input  logic [2:0]  floor_req,
    input  logic [2:0]  call_req,
    input  logic        wr_floor, wr_call,
    output logic [6:0]  seg,
    output logic [7:0]  an,
    output logic        red, green, blue
);

  logic [3:0] current_floor;
  logic [7:0] floor_req_reg, call_req_reg;
  logic [7:0] combined_req, masked_req;
  logic [2:0] target_floor;
  logic slow_clk;
  logic [7:0] mask_up, mask_down;
  logic [6:0] seg_decode [0:9];
  logic dir;

  // Delay logic
  logic at_stop_delay;
  logic [3:0] delay_counter;

  // 7-segment decoding
  initial begin
    seg_decode[0] = 7'b1000000;
    seg_decode[1] = 7'b1111001;
    seg_decode[2] = 7'b0100100;
    seg_decode[3] = 7'b0110000;
    seg_decode[4] = 7'b0011001;
    seg_decode[5] = 7'b0010010;
    seg_decode[6] = 7'b0000010;
    seg_decode[7] = 7'b1111000;
    seg_decode[8] = 7'b0000000;
    seg_decode[9] = 7'b0010000;
  end

  // Slow clock
  generate
    if (SIM) begin
      assign slow_clk = clk;
    end else begin
      logic [26:0] clkdiv;
      always_ff @(posedge clk or posedge rst) begin
        if (rst)
          clkdiv <= 0;
        else
          clkdiv <= clkdiv + 1;
      end
      assign slow_clk = clkdiv[26];
    end
  endgenerate

  // Register request logic
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      floor_req_reg <= 0;
      call_req_reg <= 0;
    end else begin
      if (wr_floor && floor_req < 8)
        floor_req_reg[floor_req] <= 1;
      if (wr_call && call_req < 8)
        call_req_reg[call_req] <= 1;

      // Clear at current floor only after stop delay is about to end
      if (enable && at_stop_delay && delay_counter == 1) begin
        floor_req_reg[current_floor] <= 0;
        call_req_reg[current_floor] <= 0;
      end
    end
  end

  assign combined_req = floor_req_reg | call_req_reg;

  // Directional mask
  always_comb begin
    mask_up   = 8'b11111111 << (current_floor + 1);
    mask_down = (8'b11111111 >> (8 - current_floor));
    masked_req = dir ? (combined_req & mask_up) : (combined_req & mask_down);
  end

  // Priority encoder
  function automatic [2:0] smart_priority_encode(
    input logic [7:0] req,
    input logic [2:0] curr_floor,
    input logic dir
  );
    integer i;
    integer best_distance;
    logic [2:0] best_floor;
    begin
      best_distance = 8;
      best_floor = curr_floor;
      for (i = 0; i < 8; i++) begin
        if (req[i]) begin
          if ((dir && i > curr_floor) || (!dir && i < curr_floor)) begin
            if ($abs(i - curr_floor) < best_distance) begin
              best_distance = $abs(i - curr_floor);
              best_floor = i[2:0];
            end
          end
        end
      end
      smart_priority_encode = best_floor;
    end
  endfunction

  // Movement FSM
  always_ff @(posedge slow_clk or posedge rst) begin
    if (rst) begin
      current_floor <= 0;
      dir <= dir_pin_init;
      target_floor <= 0;
      at_stop_delay <= 0;
      delay_counter <= 0;
    end else if (enable) begin
      if (at_stop_delay) begin
        if (delay_counter > 0) begin
          delay_counter <= delay_counter - 1;
        end else begin
          at_stop_delay <= 0;
        end
      end else if (combined_req[current_floor]) begin
        at_stop_delay <= 1;
        delay_counter <= 4;
      end else if (masked_req != 0) begin
        target_floor <= smart_priority_encode(masked_req, current_floor, dir);
        if (target_floor > current_floor)
          current_floor <= current_floor + 1;
        else if (target_floor < current_floor)
          current_floor <= current_floor - 1;
      end else if (combined_req != 0 && !at_stop_delay) begin
        dir <= ~dir;
      end
    end
  end

  // Display floor
  always_comb begin
    seg = seg_decode[current_floor];
    an  = 8'b11111110;
  end

  // RGB
  logic is_idle;
  assign is_idle = (combined_req == 0);

  always_comb begin
    if (is_idle) begin
      red = 0;
      green = 0;
      blue = 1; // idle
    end else if (at_stop_delay) begin
      red = 0;
      green = 0;
      blue = 1; // stop
    end else begin
      red = dir;
      green = ~dir;
      blue = 0; // movement
    end
  end

endmodule
