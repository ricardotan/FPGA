/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "system.h"
#include <unistd.h>

char writeChar[5] = {'h', 'e', 'l', 'l', 'o'};
short writeShort[5] = {0, 1, 2, 3, 4};
int writeInt[5] = {5, 6, 7, 8, 9};

char readChar;
short readShort;
int readInt;

char *charBase = (char *) SRAM_CONTROLLER_0_BASE;
short *shortBase = (short *) SRAM_CONTROLLER_0_BASE;
int *intBase = (int *) SRAM_CONTROLLER_0_BASE;

int main()
{
  int i;

  printf("CHAR TEST---------------------------\n");
  // charWrite
  for (i = 0; i < 5; i++){ // write char to memory
	  *charBase = writeChar[i];
	  charBase++;
  }

  for (i = 4; i > -1; i--){ // read char from memory
	  readChar = *charBase + i;
	  printf("Write: %c\tRead: %c\tAddr: %x\n", writeChar[i], readChar, charBase);
	  charBase--;
  }


  printf("SHORT TEST---------------------------\n");
  // shortWrite
  for (i = 0; i < 5; i++){ // write char to memory
  	*shortBase = writeShort[i];
  	shortBase++;
  }

  for (i = 4; i > -1; i--){ // read char from memory
  	readShort = *shortBase + i;
  	printf("Write: %i\tRead: %i\tAddr: %x\n", writeShort[i], readShort, shortBase);
  	shortBase--;
  }


  printf("INT TEST---------------------------\n");
  // intWrite
  for (i = 0; i < 5; i++){ // write char to memory
    *intBase = writeInt[i];
    intBase++;
  }

  for (i = 4; i > -1; i--){ // read char from memory
    readInt = *intBase + i;
    printf("Write: %d\tRead: %d\tAddr: %x\n", writeInt[i], readInt, intBase);
    intBase--;
  }


  return 0;
}
