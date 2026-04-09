module endianness_converter(
    input clk,
    input [31:0] word,
    input endianness_in,
    input endianness_out,
    output reg [31:0] converted_word
);

always @(posedge clk ) begin
    if (endianness_in == endianness_out) begin
        converted_word <= word;
    end else begin
        converted_word <= {word[7:0], word[15:8],word[23:16],word[31:24]};
    end
end
    
endmodule