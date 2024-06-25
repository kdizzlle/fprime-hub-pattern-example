#!/bin/bash

fpp-depend ../build-fprime-automatic-native/locs.fpp topology.fpp > deps.txt
tr '\n' ',' < deps.txt | sed 's/,$//' > deps-comma.txt
fpp-to-dict -i `cat deps-comma.txt` topology.fpp