module round_robin_arbiter_fixed_time_slices(
  input clk,
  input rst_n,
  input [3:0] REQ,
  output reg[3:0] GNT);

  reg [2:0] cst,nst;

  parameter [2:0] S_ideal = 3'b000;
  parameter [2:0] S0 = 3'b001;
  parameter [2:0] S1 = 3'b010;
  parameter [2:0] S2 = 3'b011;
  parameter [2:0] S3 = 3'b100;

  always @(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
        cst <= S_ideal;
      else
        cst <= nst;
    end

  always @(*)
    begin
      case(cst)
        S_ideal: if([REQ[0]])
          begin
            nst = S0;
          end
        else if([REQ[1]])
          begin
            nst = S1;
          end
        else if([REQ[2]])
          begin
            nst = S2;
          end
        else if([REQ[3]])
          begin
            nst = S3;
          end
        else
          begin
            nst = cst;
          end

        S0: if([REQ[1]])
          begin
            nst = S1;
          end
        else if([REQ[2]])
          begin
            nst = S2;
          end
        else if([REQ[3]])
          begin
            nst = S3;
          end
        else if([REQ[0]])
          begin
            nst = S0;
          end
        else
          begin
            nst = cst;
          end

        S1: if([REQ[2]])
          begin
            nst = S2;
          end
        else if([REQ[3]])
          begin
            nst = S3;
          end
        else if([REQ[0]])
          begin
            nst = S0;
          end
        else if([REQ[1]])
          begin
            nst = S1;
          end
        else
          begin
            nst = cst;
          end

        S2: if([REQ[3]])
          begin
            nst = S3;
          end
        else if([REQ[0]])
          begin
            nst = S0;
          end
        else if([REQ[1]])
          begin
            nst = S1;
          end
        else if([REQ[2]])
          begin
            nst = S2;
          end
        else
          begin
            nst = cst;
          end

        S3: if([REQ[0]])
          begin
            nst = S0;
          end
        else if([REQ[1]])
          begin
            nst = S1;
          end
        else if([REQ[2]])
          begin
            nst = S2;
          end
        else if([REQ[3]])
          begin
            nst = S3;
          end
        else
          begin
            nst = cst;
          end

        default: if([REQ[0]])
          begin
            nst = S0;
          end
        else if([REQ[1]])
          begin
            nst = S1;
          end
        else if([REQ[2]])
          begin
            nst = S2;
          end
        else if([REQ[3]])
          begin
            nst = S3;
          end
        else
          begin
            nst = cst;
          end

      endcase
    end

  always @(*)
    begin
      case(cst)
        S0: begin
          GNT = 4'b0001;
        end
        S1: begin
          GNT = 4'b0010;
        end
        S2: begin
          GNT = 4'b0100;
        end
        S3: begin
          GNT = 4'b1000;
        end
        default: begin
          GNT = 4'b0000;
        end
      endcase
    end
endmodule
