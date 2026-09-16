import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge


@cocotb.test()
async def test_reaction_timer(dut):

    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.rst_n.value = 0
    dut.ui_in.value = 0

    # Reset
    for _ in range(2):
        await RisingEdge(dut.clk)

    dut.rst_n.value = 1

    # Start
    dut.ui_in.value = 1

    await RisingEdge(dut.clk)

    # Release START
    dut.ui_in.value = 0

    # Count for several cycles
    for _ in range(5):
        await RisingEdge(dut.clk)

    # Stop
    dut.ui_in.value = 2

    await RisingEdge(dut.clk)

    dut.ui_in.value = 0

    print("Timer value:", int(dut.uo_out.value))
