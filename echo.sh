#!/bin/bash

function echousr()
{		
echo $x $x
}

read -p "This echos what you type: " x
echousr $x
