/*
 * Copyright (c) 2012-2014 Wind River Systems, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>

int counter = 0;

int main(void)
{
	// printk("Hello World! %s\n", CONFIG_BOARD);
	printk("counter: %i\n", counter);
}
