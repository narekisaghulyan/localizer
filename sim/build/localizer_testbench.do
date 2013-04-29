proc start {m} {vsim -L unisims_ver -L unimacro_ver -L xilinxcorelib_ver -L secureip work.glbl $m}
set MODULE localizer_testbench
start $MODULE
add wave $MODULE/*
add wave $MODULE/localizer_test/*
run 10000us
