`timescale 1ns/1ps

module projectdsd_tb();

  // === DUT Interface Signals ===
  logic clk, rst;
  logic dir_pin_init;
  logic enable;
  logic [2:0] floor_req, call_req;
  logic wr_floor, wr_call;

  logic [6:0] seg;
  logic [7:0] an;
  logic red, green, blue;

  // === Instantiate DUT ===
  projectdsd #(.SIM(1)) dut (
    .clk(clk),
    .rst(rst),
    .dir_pin_init(dir_pin_init),
    .enable(enable),
    .floor_req(floor_req),
    .call_req(call_req),
    .wr_floor(wr_floor),
    .wr_call(wr_call),
    .seg(seg),
    .an(an),
    .red(red),
    .green(green),
    .blue(blue)
  );

  // === Clock Generation: 100MHz ===
  always #5 clk = ~clk;

  // === Randomized Request Task ===
  task automatic random_requests();
    int num_requests = $urandom_range(3, 6); // Between 3 and 6 requests
    for (int i = 0; i < num_requests; i++) begin
      floor_req = $urandom_range(0, 7);
      call_req  = $urandom_range(0, 7);
      wr_floor  = 1;
      wr_call   = 1;
      #10;
      wr_floor = 0;
      wr_call  = 0;
      $display("Time %0t: Requested floor %0d, call %0d", $time, floor_req, call_req);
      #10;
    end
  endtask

  // === Self-checking monitor for basic sanity ===
  always_ff @(posedge clk) begin
    if (!rst && enable) begin
      // Display outputs for debug
      $display("Time %0t | Floor: %0d | SEG: %b | RGB: (%b %b %b)",
        $time, dut.current_floor, seg, red, green, blue);

      // Basic check: ensure only one anode is active at a time
      assert ($countones(an) == 1 || an == 8'b00000000)
        else $error("Invalid anode state at time %0t: %b", $time, an);

      // Optional: you can add coverage points here
    end
  end

  // === Initial Stimulus ===
  initial begin
    clk = 0;
    rst = 1;
    dir_pin_init = 1;
    enable = 0;
    wr_floor = 0;
    wr_call = 0;
    floor_req = 3'd0;
    call_req  = 3'd0;

    // Reset sequence
    #20 rst = 0;
    #10;

    // Generate randomized requests
    random_requests();

    // Enable elevator
    enable = 1;

    // Let it process for some time
    #500;

    // Another round of random requests
    enable = 0;
    #20;
    random_requests();
    enable = 1;

    // Let it run again
    #1000;

    $display("Test complete.");
    $finish;
  end

endmodule