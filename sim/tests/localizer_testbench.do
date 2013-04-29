set MODULE localizer_testbench
start $MODULE
add wave $MODULE/*
add wave $MODULE/localizer_test/*
run 10000us
