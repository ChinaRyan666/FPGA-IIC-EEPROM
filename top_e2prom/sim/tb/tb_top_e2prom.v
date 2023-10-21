`timescale  1ns/1ns                     //定义仿真时间单位1ns和仿真时间精度为1ns

module  tb_e2prom_top;              

//parameter  define
parameter  T = 20                          ; //时钟周期为20ns
parameter  SLAVE_ADDR     = 7'b1010000     ; //器件地址(SLAVE_ADDR)
parameter  BIT_CTRL       = 1'b1           ; //字地址位控制参数(16b/8b)
parameter  CLK_FREQ       = 26'd50_000_000 ; //i2c_dri模块的驱动时钟频率(CLK_FREQ)
parameter  I2C_FREQ       = 18'd250_000    ; //I2C的SCL时钟频率
parameter  L_TIME         = 17'd1          ; //led闪烁时间参数
parameter  MAX_BYTE       = 16'd3          ; //读写测试的字节个数

//reg define
reg          sys_clk  ;                 //时钟信号
reg          sys_rst_n;                 //复位信号

//wire define
wire         iic_scl;
wire         iic_sda;
wire         led    ;

//*****************************************************
//**                    main code
//*****************************************************

//给输入信号初始值
initial begin
    sys_clk            = 1'b0;
    sys_rst_n          = 1'b0;     //复位
    #(T+1)  sys_rst_n  = 1'b1;     //在第21ns的时候复位信号信号拉高
end

//50Mhz的时钟，周期则为1/50Mhz=20ns,所以每10ns，电平取反一次
always #(T/2) sys_clk = ~sys_clk;

//将SDA数据线上拉
pullup(iic_sda);

//例化e2prom_top模块
e2prom_top  #(
    .MAX_BYTE   (MAX_BYTE )   //读写测试的字节个数
) u_e2prom_top(
    .sys_clk    (sys_clk  ),  //系统时钟
    .sys_rst_n  (sys_rst_n),  //系统复位
    //eeprom interface
    .iic_scl    (iic_scl  ),  //eeprom的时钟线scl
    .iic_sda    (iic_sda  ),  //eeprom的数据线sda
    //user interface
    .led        (led      )   //led显示
);

//例化e2prom仿真模型
EEPROM_AT24C64 u_EEPROM_AT24C64(
    .scl         (iic_scl),
    .sda         (iic_sda)
    );

endmodule
