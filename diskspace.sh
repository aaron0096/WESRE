#!/bin/bash

df -ah > diskspace.temp
less     diskspace.temp
rm       diskspace.temp
