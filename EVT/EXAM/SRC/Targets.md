# CH32V003 SDK

## Targets

Target                              | Type       | Description 
------------------------------------|------------|-------------
`ch32v20x::core`                    | Static     | 
`ch32v20x::peripheral`              | Static     | The SDK HAL.
`ch32v20x::startup`                 | Interface  | SDK provided startup in compiled form.
`ch32v20x::startupLib`              | Static     | SDK provided startup source file.
`ch32v20x::debug-print.sdi`         | Static     | Debug print library via SDI.
`ch32v20x::debug-print.uart.pa9`<sup>DEFAULT</sup>| Static | Debug print library via UART (Port D Pin5).
`ch32v20x::debug-print.uart.pa2`    | Static     | Debug print library via UART (Port D Pin0).
`ch32v20x::debug-print.uart.pb10`    | Static     | Debug print library via UART (Port D Pin6).

> Use any one of the `debug-print::uart` targets.
> Also use one of the startup targets (`ch32v003::startup` or `ch32v003::startupLib`)

## Compile options:

Following targets adds some compile options.

Target                           | Compile option
---------------------------------|----------------
`ch32v20x::debug-print.sdi`      | `SDI_PRINT=SDI_PR_OPEN`
`ch32v20x::debug-print.uart.pa9` | `DEBUG=DEBUG_UART1`
`ch32v20x::debug-print.uart.pa2` | `DEBUG=DEBUG_UART2`
`ch32v20x::debug-print.uart.pb10`| `DEBUG=DEBUG_UART3`

## Usage guide

Define following 2 things to link with these targets.
- Define a function `SystemInit`. 
- Define a static variable `static uint32_t SystemCoreClock` of type and set it with system clock frequency to use any of the `debug-print` target. 

> Refer SDK examples to know more. To make things easy use ch32v20x_it.c, system_ch32v20x.c and system_ch32v20x.h from one of the examples.
