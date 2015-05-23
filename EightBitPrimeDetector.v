module EightBitPrimeDetector(clk, reset, number, prime, not_prime, gt20);
input clk, reset;
input [7:0] number;
reg data;
reg [7:0] num;
reg state2;
reg [1:0] state3;
reg [2:0] state5;
reg [2:0] state7;
reg [3:0] state11;
reg [3:0] state13;

reg [3:0] n;
/*output*/ reg r2, r3, r5, r7, r13, r11;

output reg prime, not_prime, gt20;

parameter A = 2'b00, B = 2'b01, C = 2'b10;


always@ (negedge clk) begin
	if (number > 5'h14)
		gt20 = 1'b1;

	if (reset) begin
		state3 <= number[7];
		state5 <= number[7];
		state7 <= number[7];
		state13 <= number[7];
		state11 <= number[7];
		state2 <= number[7];
		n = 4'b0001;
		prime = 1'b0;
		not_prime = 1'b0;
	end
	else begin 

		num = number << n;
		
		if (n == 4'b1000) begin
			r2 = ((state2 == 1'b0) && (number != 8'o2));
			r3 = ((state3 == A) && (number != 8'o3));
			r7 = ((state7 == 3'o0) && (number != 8'o7));
			r13 = ((state13 == 4'h0) && (number != 8'hd));
			r11 = ((state11 == 4'h0) && (number != 8'hb));
			r5 = ((state5 == 3'o0) && (number != 8'o5));
			
			prime = !(r2 | r3 | r5 | r7 | r11 | r13);
			not_prime = !prime;
		end
		
		data = num[7];

		case (state2)
			1'b0:
			begin
				if(data)
					state2 <= 1'b1;
				else
					state2 <= 1'b0;
			end

			1'b1:
			begin
				if(data)
					state2 <= 1'b1;
				else
					state2 <= 1'b0;
			end

		
			default : state2 <= state2;
		endcase

		case(state3)
			A:
			begin
				if(data)
					state3 <= B;
				else
					state3 <= A;
			end
			
			B:
			begin
				if(data)
					state3 <= A;
				else
					state3 <= C;
			end
				
			C:
			begin
				if(data)
					state3 <= C;
				else
					state3 <= B;
			end
			default: state3 <= state3;
		endcase // 3

		case (state5)
			3'o0:
			begin
				if(data)
					state5 <= 3'o1;
				else
					state5 <= 3'o0;
			end

			3'o1:
			begin
				if(data)
					state5 <= 3'o3;
				else
					state5 <= 3'o2;
			end

			3'o2:
			begin
				if(data)
					state5 <= 3'o0;
				else
					state5 <= 3'o4;
			end

			3'o3:
			begin
				if(data)
					state5 <= 3'o2;
				else
					state5 <= 3'o1;
			end

			3'o4:
			begin
				if(data)
					state5 <= 3'o4;
				else
					state5 <= 3'o3;
			end
		
			default : state5 <= state5;
		endcase //5


		case(state7)
			3'o0:
			begin
				if(data)
					state7 <= 3'o1;
				else
					state7 <= 3'o0;
			end
			
			3'o1:
			begin
				if(data)
					state7 <= 3'o3;
				else
					state7 <= 3'o2;
			end
				
			3'o2:
			begin
				if(data)
					state7 <= 3'o5;
				else
					state7 <= 3'o4;
			end

			3'o3:
			begin
				if(data)
					state7 <= 3'o0;
				else
					state7 <= 3'o6;
			end

			3'o4:
			begin
				if(data)
					state7 <= 3'o2;
				else
					state7 <= 3'o1;
			end

			3'o5:
			begin
				if(data)
					state7 <= 3'o4;
				else
					state7 <= 3'o3;
			end

			3'o6:
			begin
				if(data)
					state7 <= 3'o6;
				else
					state7 <= 3'o5;
			end
		
		default: state7 <= state7;
		
		endcase // 7


		case (state13)
			4'h0:
			begin
				if(data)
					state13 <= 4'h1;
				else
					state13 <= 4'h0;
			end

			
			4'h1:
			begin
				if(data)
					state13 <= 4'h3;
				else
					state13 <= 4'h2;
			end

			4'h2:
			begin
				if(data)
					state13 <= 4'h5;
				else
					state13 <= 4'h4;
			end

			4'h3:
			begin
				if(data)
					state13 <= 4'h7;
				else
					state13 <= 4'h6;
			end

			4'h4:
			begin
				if(data)
					state13 <= 4'h9;
				else
					state13 <= 4'h8;
			end

			4'h5:
			begin
				if(data)
					state13 <= 4'hb;
				else
					state13 <= 4'ha;
			end

			4'h6:
			begin
				if(data)
					state13 <= 4'h0;
				else
					state13 <= 4'hc;
			end

			4'h7:
			begin
				if(data)
					state13 <= 4'h2;
				else
					state13 <= 4'h1;
			end

			4'h8:
			begin
				if(data)
					state13 <= 4'h4;
				else
					state13 <= 4'h3;
			end

			4'h9:
			begin
				if(data)
					state13 <= 4'h6;
				else
					state13 <= 4'h5;
			end

			4'ha:
			begin
				if(data)
					state13 <= 4'h8;
				else
					state13 <= 4'h7;
			end

			4'hb:
			begin
				if(data)
					state13 <= 4'ha;
				else
					state13 <= 4'h9;
			end

			4'hc:
			begin
				if(data)
					state13 <= 4'hc;
				else
					state13 <= 4'hb;
			end

		
			default : state13 = state13;
		endcase // 13


		case (state11)
			4'h0:
			begin
				if(data)
					state11 <= 4'h1;
				else
					state11 <= 4'h0;
			end

			4'h1:
			begin
				if(data)
					state11 <= 4'h3;
				else
					state11 <= 4'h2;
			end

			4'h2:
			begin
				if(data)
					state11 <= 4'h5;
				else
					state11 <= 4'h4;
			end

			4'h3:
			begin
				if(data)
					state11 <= 4'h7;
				else
					state11 <= 4'h6;
			end

			4'h4:
			begin
				if(data)
					state11 <= 4'h9;
				else
					state11 <= 4'h8;
			end

			4'h5:
			begin
				if(data)
					state11 <= 4'h0;
				else
					state11 <= 4'ha;
			end

			4'h6:
			begin
				if(data)
					state11 <= 4'h2;
				else
					state11 <= 4'h1;
			end

			4'h7:
			begin
				if(data)
					state11 <= 4'h4;
				else
					state11 <= 4'h3;
			end

			4'h8:
			begin
				if(data)
					state11 <= 4'h6;
				else
					state11 <= 4'h5;
			end

			4'h9:
			begin
				if(data)
					state11 <= 4'h8;
				else
					state11 <= 4'h7;
			end

			4'ha:
			begin
				if(data)
					state11 <= 4'ha;
				else
					state11 <= 4'h9;
			end
		
			default : state11 = state11;
		endcase // 11




		n = n+1'b1;
	end
end

endmodule
